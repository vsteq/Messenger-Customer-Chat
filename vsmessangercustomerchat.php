<?php
/**
* 2007-2019 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2019 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

if (!defined('_PS_VERSION_')) {
    exit;
}

class Vsmessangercustomerchat extends Module
{
    protected $config_form = false;

    public $html = '';

    public function __construct()
    {
        $this->name = 'vsmessangercustomerchat';
        $this->tab = 'administration';
        $this->version = '1.1.0';
        $this->author = 'Vsteq Softwares';
        $this->need_instance = 1;
        
        /**
         * Set $this->bootstrap to true if your module is compliant with bootstrap (PrestaShop 1.6)
         */
        $this->bootstrap = true;
        
        parent::__construct();

        $this->displayName = $this->l('Messenger Customer Chat');
        $this->description = $this->l('Interact with your customer easily using facebook messenger customer chat.');

        $this->confirmUninstall = $this->l('Are you sure you uninstall my module');

        $this->ps_versions_compliancy = array('min' => '1.5', 'max' => _PS_VERSION_);
    }

    /**
     * Don't forget to create update methods if needed:
     * http://doc.prestashop.com/display/PS16/Enabling+the+Auto-Update
     */
    public function install()
    {
        Configuration::updateValue('VSLIVECHAT_LIVE_MODE', false);
        //include(dirname(__FILE__).'/sql/install.php');
        return parent::install() &&
            $this->registerHook('header') &&
            $this->registerHook('displayFooter') &&
            $this->registerHook('backOfficeHeader') &&
            $this->createsAjaxController();
    }

    public function uninstall()
    {
        Configuration::deleteByName('VSLIVECHAT_LIVE_MODE');
        //include(dirname(__FILE__).'/sql/uninstall.php');
        $this->removesAjaxContoller();
        return parent::uninstall();
    }
    
    public function createsAjaxController()
    {
        $tab = new Tab();
        $tab->active = 1;
        $languages = Language::getLanguages(false);
        if (is_array($languages)) {
            foreach ($languages as $language) {
                $tab->name[$language['id_lang']] = 'vsmessangercustomerchat';
            }
        }
        $tab->class_name = 'AdminAjaxVsmessangercustomerchat';
        $tab->module = $this->name;
        $tab->id_parent = - 1;
        return (bool)$tab->add();
    }

    private function removesAjaxContoller()
    {
        if ($tab_id = (int)Tab::getIdFromClassName('AdminAjaxVsmessangercustomerchat')) {
            $tab = new Tab($tab_id);
            $tab->delete();
        }
        return true;
    }

    /**
     * Load the configuration form
     */
    public function getContent()
    {
        $token = '&token='.Tools::getAdminTokenLite('AdminModules');
        $href = AdminController::$currentIndex.'&configure='.$this->name.$token;
        $this->context->smarty->assign('href', $href);
        /**
        * If values have been submitted in the form, process.
        */
        
        if (((bool)Tools::isSubmit('Save_Messenger_Customer_Live_Chat')) == true) {
            $this->postProcessConfiguration();
        }

        $current_lang = $this->context->language->id;
        $languages = Language::getLanguages(true, $this->context->shop->id);
        
        $grlang = array();
        if ($this->getMsgLang()) {
            foreach ($this->getMsgLang() as $key => $getlang) {
                $grlang['gm_in'][$key] = $getlang['VS_greeting_message_in'];
                $grlang['gm_out'][$key] = $getlang['VS_greeting_message_out'];
            }
        }
        
        $form_value = $this->getConfigFormValues($current_lang);
        
        $redirecturl = _PS_BASE_URL_.''.__PS_BASE_URI__.basename(_PS_ADMIN_DIR_).'/'.$href;
        
        $link = new Link();
        //$ajaxtoken = '&token='.Tools::getAdminTokenLite('AdminAjaxVsmessangercustomerchat');
        if (version_compare(_PS_VERSION_, '1.7', '<') == true) {
            $controllerlink = $link->getAdminLink('AdminAjaxVsmessangercustomerchat');
        } else {
            $controllerlink = $link->getAdminLink('AdminAjaxVsmessangercustomerchat');
        }
        if (Tools::getValue("fbsuccess") ==1) {
            $msg = $this->l('Page setup successful.');
            $this->html .= $this->successNotification($msg);
        }
        $this->context->smarty->assign('base_url', __PS_BASE_URI__);
        $this->context->smarty->assign('current_lang', $current_lang);
        $this->context->smarty->assign('languages', $languages);
        $this->context->smarty->assign('grlang', $grlang);
        $this->context->smarty->assign('module_dir', $this->_path);
        $this->context->smarty->assign('form_value', $form_value);
        $this->context->smarty->assign('controllerlink', $controllerlink);
        $this->context->smarty->assign('redirecturl', $redirecturl.'&fbsuccess=1');
        //$this->context->smarty->assign('ajaxtoken', $ajaxtoken);
        $this->html .= $this->vssetTemplates('configure', 'admin/');
        return $this->html;
    }
    
    public function getMsgLang($lang_id = null)
    {
        $return = unserialize(Configuration::get('vs_gr_lang'));
        $grlang = array();
        if (!empty($return) && $lang_id != null) {
            foreach ($return as $key => $getlang) {
                if ($key == $lang_id) {
                    $grlang['VS_greeting_message_in'] = $getlang['VS_greeting_message_in'];
                    $grlang['VS_greeting_message_out'] = $getlang['VS_greeting_message_out'];
                }
            }
            return $grlang;
        }
        return $return;
    }
    
    public function saveMsgLang()
    {
        $languages = Language::getLanguages(true, $this->context->shop->id);
        $vs_gr_lang = array();
        foreach ($languages as $language) {
            $l_id = $language['id_lang'];
            
            if (!Validate::isMessage(Tools::getValue('VS_greeting_message_in_'.$l_id))) {
                $msg = $this->l('Logged in greeting in not an valid');
                $this->html .= $this->errorNotification($msg);
                return true;
            } elseif (!Validate::isMessage(Tools::getValue('VS_greeting_message_out_'.$l_id))) {
                $msg = $this->l('Logged out greeting in not an valid');
                $this->html .= $this->errorNotification($msg);
                return true;
            }
            
            $vs_gr_lang[$l_id] = array(
                'VS_greeting_message_in' => Tools::getValue('VS_greeting_message_in_'.$l_id),
                'VS_greeting_message_out' => Tools::getValue('VS_greeting_message_out_'.$l_id)
            );
            Configuration::updateValue('vs_gr_lang', serialize($vs_gr_lang));
        }
    }

    /**
    * Set values for the inputs.
    */
    protected function getConfigFormValues($current_lang = null)
    {
        if ($current_lang != null) {
            $getMsgLang = $this->getMsgLang($current_lang);
            
            if (!empty($getMsgLang)) {
                $VS_greeting_message_in = $getMsgLang['VS_greeting_message_in'];
                $VS_greeting_message_out = $getMsgLang['VS_greeting_message_out'];
            } else {
                $VS_greeting_message_in = null;
                $VS_greeting_message_out = null;
            }
        } else {
            $VS_greeting_message_in = null;
            $VS_greeting_message_out = null;
        }
        
        return array(
            'VSLIVECHAT_LIVE_MODE' => Configuration::get('VSLIVECHAT_LIVE_MODE'),
            'VSEnable_send_us_message' => Configuration::get('VSEnable_send_us_message'),
            'VS_fb_appid' => Configuration::get('VS_fb_appid'),
            'VS_fb_page_id' => Configuration::get('VS_fb_page_id'),
            
            'VS_greeting_message_in' => $VS_greeting_message_in,
            'VS_greeting_message_out' => $VS_greeting_message_out,
            
            'VS_position' => Configuration::get('VS_position'),
            'VS_left_padding' => Configuration::get('VS_left_padding'),
            'VS_right_padding' => Configuration::get('VS_right_padding'),
            
            'VS_theme_color' => Configuration::get('VS_theme_color'),
            'VS_button_color' => Configuration::get('VS_button_color'),
            'VS_size_of_button' => Configuration::get('VS_size_of_button'),
            'VS_greeting_dialog_display' => Configuration::get('VS_greeting_dialog_display'),
            'VS_auto_open_delay' => Configuration::get('VS_auto_open_delay'),
            'VS_working_hours' => Configuration::get('VS_working_hours'),

            'VS_day_check_Monday' => Configuration::get('VS_day_check_Monday'),
            'VS_day_check_Tuesday' => Configuration::get('VS_day_check_Tuesday'),
            'VS_day_check_Wednesday' => Configuration::get('VS_day_check_Wednesday'),
            'VS_day_check_Thursday' => Configuration::get('VS_day_check_Thursday'),
            'VS_day_check_Friday' => Configuration::get('VS_day_check_Friday'),
            'VS_day_check_Saturday' => Configuration::get('VS_day_check_Saturday'),
            'VS_day_check_Sunday' => Configuration::get('VS_day_check_Sunday'),

            'VS_Monday_open' => Configuration::get('VS_Monday_open'),
            'VS_Tuesday_open' => Configuration::get('VS_Tuesday_open'),
            'VS_Wednesday_open' => Configuration::get('VS_Wednesday_open'),
            'VS_Thursday_open' => Configuration::get('VS_Thursday_open'),
            'VS_Friday_open' => Configuration::get('VS_Friday_open'),
            'VS_Saturday_open' => Configuration::get('VS_Saturday_open'),
            'VS_Sunday_open' => Configuration::get('VS_Sunday_open'),

            'VS_Monday_close' => Configuration::get('VS_Monday_close'),
            'VS_Tuesday_close' => Configuration::get('VS_Tuesday_close'),
            'VS_Wednesday_close' => Configuration::get('VS_Wednesday_close'),
            'VS_Thursday_close' => Configuration::get('VS_Thursday_close'),
            'VS_Friday_close' => Configuration::get('VS_Friday_close'),
            'VS_Saturday_close' => Configuration::get('VS_Saturday_close'),
            'VS_Sunday_close' => Configuration::get('VS_Sunday_close')

        );
    }

    /**
     * Save form data.
     */
    protected function postProcessConfiguration()
    {
        $VS_auto_open_delay = Tools::getValue('VS_auto_open_delay');
        if (Tools::getValue('VS_fb_page_id') && !preg_match('/^\d+$/', Tools::getValue('VS_fb_page_id'))) {
            $msg = $this->l('Page Id in not an valid');
            $this->html .= $this->errorNotification($msg);
            return false;
        } elseif ($VS_auto_open_delay && !preg_match('/^\d+$/', Tools::getValue('VS_auto_open_delay'))) {
            $msg = $this->l('Greeting dialog display Sets the number of seconds in not an valid');
            $this->html .= $this->errorNotification($msg);
            return false;
        } elseif ($this->saveMsgLang()) {
            return false;
        } elseif (Tools::getValue('VS_fb_appid') && !preg_match('/^\d+$/', Tools::getValue('VS_fb_appid'))) {
            $msg = $this->l('App Id in not an valid');
            $this->html .= $this->errorNotification($msg);
            return false;
        }
        
        Configuration::updateValue('VSLIVECHAT_LIVE_MODE', Tools::getValue('VSLIVECHAT_LIVE_MODE'));
        Configuration::updateValue('VSEnable_send_us_message', Tools::getValue('VSEnable_send_us_message'));
        Configuration::updateValue('VS_fb_appid', Tools::getValue('VS_fb_appid'));
        Configuration::updateValue('VS_fb_page_id', Tools::getValue('VS_fb_page_id'));
        
        Configuration::updateValue('VS_position', Tools::getValue('VS_position'));
        Configuration::updateValue('VS_left_padding', Tools::getValue('VS_left_padding'));
        Configuration::updateValue('VS_right_padding', Tools::getValue('VS_right_padding'));
        
        Configuration::updateValue('VS_theme_color', Tools::getValue('VS_theme_color'));
        Configuration::updateValue('VS_button_color', Tools::getValue('VS_button_color'));
        Configuration::updateValue('VS_size_of_button', Tools::getValue('VS_size_of_button'));
        Configuration::updateValue('VS_greeting_dialog_display', Tools::getValue('VS_greeting_dialog_display'));
        Configuration::updateValue('VS_auto_open_delay', Tools::getValue('VS_auto_open_delay'));
        Configuration::updateValue('VS_working_hours', Tools::getValue('VS_working_hours'));


        Configuration::updateValue('VS_day_check_Monday', Tools::getValue('VS_day_check_Monday'));
        Configuration::updateValue('VS_day_check_Tuesday', Tools::getValue('VS_day_check_Tuesday'));
        Configuration::updateValue('VS_day_check_Wednesday', Tools::getValue('VS_day_check_Wednesday'));
        Configuration::updateValue('VS_day_check_Thursday', Tools::getValue('VS_day_check_Thursday'));
        Configuration::updateValue('VS_day_check_Friday', Tools::getValue('VS_day_check_Friday'));
        Configuration::updateValue('VS_day_check_Saturday', Tools::getValue('VS_day_check_Saturday'));
        Configuration::updateValue('VS_day_check_Sunday', Tools::getValue('VS_day_check_Sunday'));

        if (Tools::getValue('VS_day_check_Monday')) {
            Configuration::updateValue('VS_Monday_open', Tools::getValue('VS_Monday_open'));
            Configuration::updateValue('VS_Monday_close', Tools::getValue('VS_Monday_close'));
        } else {
            Configuration::updateValue('VS_Monday_open', false);
            Configuration::updateValue('VS_Monday_close', false);
        }
        if (Tools::getValue('VS_day_check_Tuesday')) {
            Configuration::updateValue('VS_Tuesday_open', Tools::getValue('VS_Tuesday_open'));
            Configuration::updateValue('VS_Tuesday_close', Tools::getValue('VS_Tuesday_close'));
        } else {
            Configuration::updateValue('VS_Tuesday_open', false);
            Configuration::updateValue('VS_Tuesday_close', false);
        }
        if (Tools::getValue('VS_day_check_Wednesday')) {
            Configuration::updateValue('VS_Wednesday_open', Tools::getValue('VS_Wednesday_open'));
            Configuration::updateValue('VS_Wednesday_close', Tools::getValue('VS_Wednesday_close'));
        } else {
            Configuration::updateValue('VS_Wednesday_open', false);
            Configuration::updateValue('VS_Wednesday_close', false);
        }

        if (Tools::getValue('VS_day_check_Thursday')) {
            Configuration::updateValue('VS_Thursday_open', Tools::getValue('VS_Thursday_open'));
            Configuration::updateValue('VS_Thursday_close', Tools::getValue('VS_Thursday_close'));
        } else {
            Configuration::updateValue('VS_Thursday_open', false);
            Configuration::updateValue('VS_Thursday_close', false);
        }

        if (Tools::getValue('VS_day_check_Friday')) {
            Configuration::updateValue('VS_Friday_open', Tools::getValue('VS_Friday_open'));
            Configuration::updateValue('VS_Friday_close', Tools::getValue('VS_Friday_close'));
        } else {
            Configuration::updateValue('VS_Friday_open', false);
            Configuration::updateValue('VS_Friday_close', false);
        }

        if (Tools::getValue('VS_day_check_Saturday')) {
            Configuration::updateValue('VS_Saturday_open', Tools::getValue('VS_Saturday_open'));
            Configuration::updateValue('VS_Saturday_close', Tools::getValue('VS_Saturday_close'));
        } else {
            Configuration::updateValue('VS_Saturday_open', false);
            Configuration::updateValue('VS_Saturday_close', false);
        }

        if (Tools::getValue('VS_day_check_Sunday')) {
            Configuration::updateValue('VS_Sunday_open', Tools::getValue('VS_Sunday_open'));
            Configuration::updateValue('VS_Sunday_close', Tools::getValue('VS_Sunday_close'));
        } else {
            Configuration::updateValue('VS_Sunday_open', false);
            Configuration::updateValue('VS_Sunday_close', false);
        }
        $msg = $this->l('Configuration update successfully.');
        $this->html .= $this->successNotification($msg);
    }

    public function successNotification($msg)
    {
        $this->context->smarty->assign('msg', $msg);
        return $this->vssetTemplates('success', 'admin/');
    }

    public function errorNotification($msg)
    {
        $this->context->smarty->assign('msg', $msg);
        return $this->vssetTemplates('error', 'admin/');
    }

    public function vssetTemplates($tplname, $folder = null)
    {
        if (version_compare(_PS_VERSION_, '1.6', '>') == true) {
            $output = $this->context->smarty->fetch($this->local_path.'views/templates/'.$folder.$tplname.'.tpl');
        } elseif (version_compare(_PS_VERSION_, '1.6', '<') == true) {
            $output = $this->display(__FILE__, 'views/templates/'.$folder.$tplname.'_1_5.tpl');
        } else {
            $output = $this->display(__FILE__, 'views/templates/'.$folder.$tplname.'_1_6.tpl');
        }
        return $output;
    }

    /**
    * Add the CSS & JavaScript files you want to be loaded in the BO.
    */
    public function hookBackOfficeHeader($params)
    {
        if (Tools::getValue('configure') == $this->name) {
            $module_url = Tools::getProtocol(Tools::usingSecureMode()).$_SERVER['HTTP_HOST'].$this->getPathUri();
            $this->html = '<script type="text/javascript" src="'.__PS_BASE_URI__;
            $this->html .= 'js/jquery/plugins/jquery.colorpicker.js"></script>';
            $this->html .= '<script type="text/javascript" src="'.$module_url;
            $this->html .= 'views/js/back.js"></script>';
            $this->html .= '<link rel="stylesheet" href="'.$module_url.'views/css/back.css">';
            return $this->html;
        }
    }

    /**
     * Add the CSS & JavaScript files you want to be added on the FO.
     */
    public function hookHeader()
    {
        $this->context->controller->addJS($this->_path.'/views/js/front.js');
        $this->context->controller->addCSS($this->_path.'/views/css/front.css');
    }

    public function hookDisplayFooter($params)
    {
        $lang_id = $this->context->language->id;
        /**
        * retrieve config data.
        */
        $configData = $this->getConfigFormValues($lang_id);
        
        /**
         * Check if Customer Chat Enabled.
         */
        if (!$configData['VSLIVECHAT_LIVE_MODE']) {
            return false;
        }
        
        /* Check if Customer Chat Available at current time */
        $slotOk = 0;
        $curr_day = date("l");
        if ($configData['VS_working_hours'] == 1) {
            $day_data = $configData['VS_day_check_'.$curr_day];
            $open_data = $configData['VS_'.$curr_day.'_open'];
            
            $close_data = $configData['VS_'.$curr_day.'_close'];
            if ($day_data && ($open_data || $open_data == "0")) {
                $curr_time = date("G:i");
                $open_time = floor($open_data/60).':'.$open_data%60;
                $close_time = floor($close_data/60).':'.$close_data%60;
                
                if ($open_time <= $curr_time && $close_time >= $curr_time) {
                    $slotOk = 1;
                }
            }
        } else {
            $slotOk = 1;
        }
        
        $Send_message = 0;
        if ($slotOk == 0 && !$configData['VS_working_hours']) {
            return false;
        } elseif ($slotOk == 0 && $configData['VS_working_hours']) {
            $Send_message = 1;
        }
        
        $fb_LANG = 'en_US';
        if ($this->context->language->iso_code) {
            $fb_LANG = $this->context->language->iso_code.'_'.Tools::strtoupper($this->context->language->iso_code);
        }
        
        $this->context->smarty->assign('configData', $configData);
        $this->context->smarty->assign(
            array(
                'configData' => $configData,
                'Send_message' => $Send_message,
                'lang' => $fb_LANG,
             )
        );
        return $this->vssetTemplates('dispalyfooter', 'hook/');
    }
}

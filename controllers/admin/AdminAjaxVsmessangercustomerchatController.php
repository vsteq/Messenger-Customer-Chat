<?php
/**
* 2007-2018 PrestaShop
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
* @author    PrestaShop SA <contact@prestashop.com>
* @copyright 2007-2018 PrestaShop SA
* @license   http://addons.prestashop.com/en/content/12-terms-and-conditions-of-use
* International Registered Trademark & Property of PrestaShop SA
*/

if (!defined('_PS_VERSION_')) {
    exit;
}

class AdminAjaxVsmessangercustomerchatController extends ModuleAdminController
{
    public function __construct()
    {
        $token = Tools::getValue('token') ? Tools::getValue('token') : 'Invalid token';
        if ($token != Tools::getAdminTokenLite('AdminAjaxVsmessangercustomerchat')) {
            die('Invalid token');
        }

        parent::__construct();

        $this->postProcess();

        //die;
    }
    
    public function postProcess()
    {
        $pageID = Tools::getValue("pageID");
        //$locale = Tools::getValue("locale");
        $themeColor = Tools::getValue("themeColor");
        //$greetingText = Tools::getValue("greetingText");

        Configuration::updateValue('VS_fb_page_id', $pageID);
        //Configuration::updateValue('VS_greeting_message', $greetingText);
        Configuration::updateValue('VS_theme_color', $themeColor);
        
        $return = json_encode('1');
        echo $return;
        exit;
        //$this->ajaxDie(json_encode('1'));
        //$this->ajaxDie("1");
    }
}

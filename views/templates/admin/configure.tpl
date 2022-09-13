{*

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

*}

<div id="config_msg"></div>
<div class="panel">

    <div class="panel-heading">

        <i class="icon-AdminAdmin"></i> {l s='Configuration' mod='vsmessangercustomerchat'}

        <img src="{$module_dir|escape:'htmlall':'UTF-8'}views/img/loading.gif" style="display:none" width="20px" id="loder01">

    </div>

    

    <form method="post" id="save_config_form" class="defaultForm form-horizontal" action="{$href|escape:'htmlall'}" enctype="multipart/form-data" >

    <div class="panel-body">

        <div class="form-wrapper">

            <div class="form-group">

                <input type="hidden" name="controllerurl" id="controllerurl" value="{$controllerlink|escape:'htmlall':'UTF-8'}"/>

                <input type="hidden" name="redirecthref" id="redirecthref" value="{$redirecturl|escape:'htmlall':'UTF-8'}"/>

                <label class="control-label col-lg-3" for="SetupCustomerChat">

                    <strong>{l s='Setup Customer Chat' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-9">

                    <button type="button" onclick="vs_setupCustomerChat()" id="SetupCustomerChat" name="SetupCustomerChat" class="btn" style="background-color:#4267b2; border:1px solid #4267b2; color:white; font-weight:600; /*padding:2px 8px 2px 0px;*/">

                        <!--<img src="{$module_dir|escape:'htmlall'}views/img/fb.ico" width="20" style="width:20px; padding:0px 0px 5px 0px;">-->

                        {l s='Setup Customer Chat' mod='vsmessangercustomerchat'}

                    </button>

                    <span style="padding:5px 5px; font-size:14px; color:green;">

                        {if $form_value.VS_fb_page_id}{$form_value.VS_fb_page_id|escape:'htmlall':'UTF-8'}{/if}

                    </span>

                </div>

            </div>

            <div class="form-group">

                <label class="control-label col-lg-3" for="VSLIVECHAT_LIVE_MODE">

                    <strong>{l s='Enable Customer Chat' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-9">

                    <span class="switch prestashop-switch fixed-width-lg">

                        <input type="radio" name="VSLIVECHAT_LIVE_MODE" id="VSLIVECHAT_LIVE_MODE_on" value="1" {if $form_value.VSLIVECHAT_LIVE_MODE == 1}checked="checked"{/if}>

                        <label for="VSLIVECHAT_LIVE_MODE_on" class="radioCheck">Yes</label>

                        <input type="radio" name="VSLIVECHAT_LIVE_MODE" id="VSLIVECHAT_LIVE_MODE_off" value="0" {if $form_value.VSLIVECHAT_LIVE_MODE == 0}checked="checked"{/if}>

                        <label for="VSLIVECHAT_LIVE_MODE_off" class="radioCheck">No</label>

                        <a class="slide-button btn"></a>

                    </span>

                    <div class="clearfix"></div>

                    <p class="help-block">{l s='Enable fb customer live chat' mod='vsmessangercustomerchat'}</p>

                </div>

            </div>

            

            

            <div class="form-group">

                <label class="control-label col-lg-3" for="VS_fb_page_id">

                <strong>{l s='Page Id' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-9">

                    <input type="text" name="VS_fb_page_id" id="VS_fb_page_id" value="{if $form_value.VS_fb_page_id}{$form_value.VS_fb_page_id|escape:'htmlall':'UTF-8'}{/if}" />

                    <p class="help-block">

                        {l s='Enter your facebook Page Id' mod='vsmessangercustomerchat'}

                    </p>

                </div>

            </div>

            

            <div class="form-group">

                <label class="control-label col-lg-3" for="VS_greeting_dialog_display">

                <strong>{l s='Greeting dialog display' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-9">

                    <select class="VS_greeting_dialog_display col-lg-4" name="VS_greeting_dialog_display" id="VS_greeting_dialog_display">

                        <option value="show" {if $form_value.VS_greeting_dialog_display=='Show'}selected="selected"{/if}>{l s='Show' mod='vsmessangercustomerchat'}</option>

                        <option value="fade" {if $form_value.VS_greeting_dialog_display=='Fade'}selected="selected"{/if}>{l s='Fade' mod='vsmessangercustomerchat'}</option>

                        <option value="hide" {if $form_value.VS_greeting_dialog_display=='Hide'}selected="selected"{/if}>{l s='Hide' mod='vsmessangercustomerchat'}</option>

                    </select>

                    <div class="clearfix"></div>

                    <p class="help-block">{l s='Sets how the greeting dialog will be displayed at first visit, Greeting dialog will be shown minimized on mobile.' mod='vsmessangercustomerchat'}</p>

                </div>

            </div>

            

            <div class="form-group">

                <label class="control-label col-lg-3" for="VS_auto_open_delay">

                <strong>{l s='Greeting dialog display' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-9">

                    <div class="input-group col-lg-4 pull-left">

                    <input type="text" name="VS_auto_open_delay" class="VS_auto_open_delay" id="VS_auto_open_delay" value="{if $form_value.VS_auto_open_delay}{$form_value.VS_auto_open_delay|escape:'htmlall':'UTF-8'}{/if}"/><span class="input-group-addon">{l s='sec' mod='vsmessangercustomerchat'}</span>

                    </div>

                    <div class="clearfix"></div>

                    <p class="help-block">{l s='Sets the number of seconds of delay before the greeting dialog is shown after the module is loaded.' mod='vsmessangercustomerchat'}</p>

                </div>

            </div>

            

            <div class="form-group">

                <label class="control-label col-lg-3" for="vs_greeting_message_in">

                <strong>{l s='Logged in greeting' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-9">

                    <div class="col-lg-8 pull-left">

                        {foreach from=$languages key=lang item=i}

                            <textarea class="form-control" id="vs_greeting_message_in{$i.id_lang|escape:'htmlall':'UTF-8'}" name="VS_greeting_message_in_{$i.id_lang|escape:'htmlall':'UTF-8'}" {if $current_lang != $i.id_lang} style="display:none;" {/if} maxlength="80">{if isset($grlang.gm_in[$i.id_lang])}{$grlang.gm_in[$i.id_lang]|escape:'htmlall':'UTF-8'}{/if}</textarea>

                        {/foreach}

                    </div>

                    <select class="VS_login_greeting_message_lang col-lg-1 pull-left" name="VS_login_greeting_message_lang" id="VS_login_greeting_message_lang">

                        {foreach from=$languages key=lang item=i}

                        <option value="{$i.id_lang|escape:'htmlall':'UTF-8'}" {if $current_lang==$i.id_lang}selected="selected"{/if}>{$i.iso_code|escape:'htmlall':'UTF-8'}</option>

                        {/foreach}

                    </select>

                    <div class="clearfix"></div>

                    <p class="help-block">{l s='Greeting message for customer who are logged in facebook.' mod='vsmessangercustomerchat'}</p>

                </div>

            </div>

            

            <div class="form-group">

                <label class="control-label col-lg-3" for="vs_greeting_message_out">

                <strong>{l s='Logged out greeting' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-9">

                    <div class="col-lg-8 pull-left">

                        {foreach from=$languages key=lang item=i}

                            <textarea class="form-control" id="vs_greeting_message_out{$i.id_lang|escape:'htmlall':'UTF-8'}" name="VS_greeting_message_out_{$i.id_lang|escape:'htmlall':'UTF-8'}" {if $current_lang != $i.id_lang} style="display:none;" {/if} maxlength="80">{if isset($grlang.gm_out[$i.id_lang])}{$grlang.gm_out[$i.id_lang|escape:'htmlall':'UTF-8']}{/if}</textarea>

                        {/foreach}

                    </div>

                    <select class="VS_logout_greeting_message_lang col-lg-1 pull-left" name="VS_logout_greeting_message_lang" id="VS_logout_greeting_message_lang">

                        {foreach from=$languages key=lang item=i}

                        <option value="{$i.id_lang|escape:'htmlall':'UTF-8'}" {if $current_lang==$i.id_lang}selected="selected"{/if}>{$i.iso_code|escape:'htmlall':'UTF-8'}</option>

                        {/foreach}

                    </select>

                    <div class="clearfix"></div>

                    <p class="help-block">{l s='Greeting message for customer who are not logged in facebook.' mod='vsmessangercustomerchat'}</p>

                </div>

            </div>

            <div class="form-group">

                <label class="control-label col-lg-3" for="VS_position">

                <strong>{l s='Position' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-9">

                    <select class="VS_position col-lg-4" name="VS_position" id="VS_position">                        
                        
						<option value="Default" selected="selected">{l s='Default' mod='vsmessangercustomerchat'}</option>
						
						<option value="left" {if $form_value.VS_position=='left'}selected="selected"{/if}>{l s='Left' mod='vsmessangercustomerchat'}</option>

                        <option value="right" {if $form_value.VS_position=='right'}selected="selected"{/if}>{l s='Right' mod='vsmessangercustomerchat'}</option>

                    </select>
					
					<div class="clearfix"></div>

                    <p class="help-block">{l s='Select Your Position.' mod='vsmessangercustomerchat'}</p>

                </div>

            </div>
			
			<div class="form-group" id="VS_left_padding_form" {if $form_value.VS_position=='right' || $form_value.VS_position=='Default'}style="display:none;"{/if}>

                <label class="control-label col-lg-3" for="VS_left_padding">

                <strong>{l s='Left Padding' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-3">

                    <input type="text" name="VS_left_padding" id="VS_left_padding" value="{if $form_value.VS_left_padding}{$form_value.VS_left_padding|escape:'htmlall':'UTF-8'}{/if}" />

                    <p class="help-block">

                        {l s='Enter Left Padding' mod='vsmessangercustomerchat'}

                    </p>

                </div>

            </div>
			
			
			
			<div class="form-group" id="VS_right_padding_form" {if $form_value.VS_position=='left' || $form_value.VS_position=='Default'}style="display:none;"{/if}>

                <label class="control-label col-lg-3" for="VS_right_padding">

                <strong>{l s='Right Padding' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-3">

                    <input type="text" name="VS_right_padding" id="VS_right_padding" value="{if $form_value.VS_right_padding}{$form_value.VS_right_padding|escape:'htmlall':'UTF-8'}{/if}" />

                    <p class="help-block">

                        {l s='Enter Right Padding' mod='vsmessangercustomerchat'}

                    </p>

                </div>

            </div>
			
			

            <div class="form-group">

                <label class="control-label col-lg-3" for="VS_theme_color">

                <strong>{l s='Theme color' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-9">

                    <div class="input-group col-lg-4 pull-left">

                    <input type="text" name="VS_theme_color" class="mColorPicker" id="color_0" value="{if $form_value.VS_theme_color}{$form_value.VS_theme_color|escape:'htmlall':'UTF-8'}{/if}" data-hex="true" style="background-color:{if $form_value.VS_theme_color}{$form_value.VS_theme_color|escape:'htmlall':'UTF-8'}{/if};"/><span id="icp_color_0" class="mColorPickerTrigger input-group-addon" data-mcolorpicker="true"><img src="../img/admin/color.png" /></span>

                    </div>

                    <div class="clearfix"></div>

                    <p class="help-block">{l s='The color to use as a theme for the module, including the background color of the customer chat module icon and the backgound color of any messages sent by users.' mod='vsmessangercustomerchat'}</p>

                </div>

            </div>

            

            <div class="form-group">

                <label class="control-label col-lg-3" for="VS_working_hours">

					<strong>{l s='Working hours' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-9">

                    <span class="switch prestashop-switch fixed-width-lg">

                        <input type="radio" name="VS_working_hours" id="VS_working_hours_on" value="1" {if $form_value.VS_working_hours == 1}checked="checked"{/if}>

                        <label for="VS_working_hours_on" class="radioCheck">Yes</label>

                        <input type="radio" name="VS_working_hours" id="VS_working_hours_off" value="0" {if $form_value.VS_working_hours == 0}checked="checked"{/if}>

                        <label for="VS_working_hours_off" class="radioCheck">No</label>

                        <a class="slide-button btn"></a>

                    </span>

                    <div class="clearfix"></div>

                    <p class="help-block">{l s='turn it on to configure your working hours, Messanger icon will only appear when you are working.' mod='vsmessangercustomerchat'}</p>

                </div>

            </div>

            

            <div class="form-group">

            <div class="col-lg-8" style="margin:0px auto; float:none;">

                <label class="control-label col-lg-2" for="VS_day_check_Monday" style="text-align:left;">

                <input type="checkbox" name="VS_day_check_Monday" id="VS_day_check_Monday" value="1" {if $form_value.VS_day_check_Monday == 1}checked="checked"{/if}>

                <strong>{l s='Monday' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-10 sliders">

                        <div class="slider" id="Monday"></div>

                        <span class="range" style="vertical-align:-webkit-baseline-middle;">

                            {if $form_value.VS_day_check_Monday == 0}

                                {l s='Closed' mod='vsmessangercustomerchat'}

                            {/if}

                        </span>

                        

                        <input type="hidden" class="Vs_Open" name="VS_Monday_open" data-index="0" value="{if $form_value.VS_day_check_Monday}{$form_value.VS_Monday_open|escape:'htmlall':'UTF-8'}{/if}"/>

                        <input type="hidden" class="Vs_Close" name="VS_Monday_close" data-index="1" value="{if $form_value.VS_day_check_Monday}{$form_value.VS_Monday_close|escape:'htmlall':'UTF-8'}{/if}"/>

                </div>

                

                <div class="clearfix"></div>

                

                <label class="control-label col-lg-2" for="VS_day_Tuesday" style="text-align:left;">

                <input type="checkbox" name="VS_day_check_Tuesday" id="VS_day_Tuesday" value="1" {if $form_value.VS_day_check_Tuesday == 1}checked="checked"{/if}>

                <strong>{l s='Tuesday' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-10 sliders">

                        <div class="slider" id="Tuesday"></div>

                        <span class="range" style="vertical-align:-webkit-baseline-middle;">

                            {if $form_value.VS_day_check_Tuesday == 0}

                                {l s='Closed' mod='vsmessangercustomerchat'}

                            {/if}

                        </span>

                        

                        <input type="hidden" class="Vs_Open" name="VS_Tuesday_open" data-index="0" value="{if $form_value.VS_day_check_Tuesday}{$form_value.VS_Tuesday_open|escape:'htmlall':'UTF-8'}{/if}"/>

                        <input type="hidden" class="Vs_Close" name="VS_Tuesday_close" data-index="1" value="{if $form_value.VS_day_check_Tuesday}{$form_value.VS_Tuesday_close|escape:'htmlall':'UTF-8'}{/if}"/>

                </div>

                

                <div class="clearfix"></div>

                

                <label class="control-label col-lg-2" for="VS_day_Wednesday" style="text-align:left;">

                <input type="checkbox" name="VS_day_check_Wednesday" id="VS_day_Wednesday" value="1" {if $form_value.VS_day_check_Wednesday == 1}checked="checked"{/if}>

                <strong>{l s='Wednesday' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-10 sliders">

                        <div class="slider" id="Wednesday"></div>

                        <span class="range" style="vertical-align:-webkit-baseline-middle;">

                            {if $form_value.VS_day_check_Wednesday == 0}

                                {l s='Closed' mod='vsmessangercustomerchat'}

                            {/if}

                        </span>

                        

                        <input type="hidden" class="Vs_Open" name="VS_Wednesday_open" data-index="0" value="{if $form_value.VS_day_check_Wednesday}{$form_value.VS_Wednesday_open|escape:'htmlall':'UTF-8'}{/if}"/>

                        <input type="hidden" class="Vs_Close" name="VS_Wednesday_close" data-index="1" value="{if $form_value.VS_day_check_Wednesday}{$form_value.VS_Wednesday_close|escape:'htmlall':'UTF-8'}{/if}"/>

                </div>

                

                <div class="clearfix"></div>

                

                <label class="control-label col-lg-2" for="VS_day_Thursday" style="text-align:left;">

                <input type="checkbox" name="VS_day_check_Thursday" id="VS_day_Thursday" value="1" {if $form_value.VS_day_check_Thursday == 1}checked="checked"{/if}>

                <strong>{l s='Thursday' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-10 sliders">

                        <div class="slider" id="Thursday"></div>

                        <span class="range" style="vertical-align:-webkit-baseline-middle;">

                            {if $form_value.VS_day_check_Thursday == 0}

                                {l s='Closed' mod='vsmessangercustomerchat'}

                            {/if}

                        </span>

                        

                        <input type="hidden" class="Vs_Open" name="VS_Thursday_open" data-index="0" value="{if $form_value.VS_day_check_Thursday}{$form_value.VS_Thursday_open|escape:'htmlall':'UTF-8'}{/if}"/>

                        <input type="hidden" class="Vs_Close" name="VS_Thursday_close" data-index="1" value="{if $form_value.VS_day_check_Thursday}{$form_value.VS_Thursday_close|escape:'htmlall':'UTF-8'}{/if}"/>

                </div>

                

                <div class="clearfix"></div>

                

                <label class="control-label col-lg-2" for="VS_day_Friday" style="text-align:left;">

                <input type="checkbox" name="VS_day_check_Friday" id="VS_day_Friday" value="1" {if $form_value.VS_day_check_Friday == 1}checked="checked"{/if}>

                <strong>{l s='Friday' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-10 sliders">

                        <div class="slider" id="Friday"></div>

                        <span class="range" style="vertical-align:-webkit-baseline-middle;">

                            {if $form_value.VS_day_check_Friday == 0}

                                {l s='Closed' mod='vsmessangercustomerchat'}

                            {/if}

                        </span>

                        

                        <input type="hidden" class="Vs_Open" name="VS_Friday_open" data-index="0" value="{if $form_value.VS_day_check_Friday}{$form_value.VS_Friday_open|escape:'htmlall':'UTF-8'}{/if}"/>

                        <input type="hidden" class="Vs_Close" name="VS_Friday_close" data-index="1" value="{if $form_value.VS_day_check_Friday}{$form_value.VS_Friday_close|escape:'htmlall':'UTF-8'}{/if}"/>

                </div>

                

                <div class="clearfix"></div>

                

                <label class="control-label col-lg-2" for="VS_day_Saturday" style="text-align:left;">

                <input type="checkbox" name="VS_day_check_Saturday" id="VS_day_Saturday" value="1" {if $form_value.VS_day_check_Saturday == 1}checked="checked"{/if}>

                <strong>{l s='Saturday' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-10 sliders">

                        <div class="slider" id="Saturday"></div>

                        <span class="range" style="vertical-align:-webkit-baseline-middle;">

                            {if $form_value.VS_day_check_Saturday == 0}

                                {l s='Closed' mod='vsmessangercustomerchat'}

                            {/if}

                        </span>

                        

                        <input type="hidden" class="Vs_Open" name="VS_Saturday_open" data-index="0" value="{if $form_value.VS_day_check_Saturday}{$form_value.VS_Saturday_open|escape:'htmlall':'UTF-8'}{/if}"/>

                        <input type="hidden" class="Vs_Close" name="VS_Saturday_close" data-index="1" value="{if $form_value.VS_day_check_Saturday}{$form_value.VS_Saturday_close|escape:'htmlall':'UTF-8'}{/if}"/>

                </div>

                

                <div class="clearfix"></div>

                

                <label class="control-label col-lg-2" for="VS_day_Sunday" style="text-align:left;">

                <input type="checkbox" name="VS_day_check_Sunday" id="VS_day_Sunday" value="1" {if $form_value.VS_day_check_Sunday == 1}checked="checked"{/if}>

                <strong>{l s='Sunday' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-10 sliders">

                        <div class="slider" id="Sunday"></div>

                        <span class="range" style="vertical-align:-webkit-baseline-middle;">

                            {if $form_value.VS_day_check_Sunday == 0}

                                {l s='Closed' mod='vsmessangercustomerchat'}

                            {/if}

                        </span>

                        

                        <input type="hidden" class="Vs_Open" name="VS_Sunday_open" data-index="0"  value="{if $form_value.VS_day_check_Sunday}{$form_value.VS_Sunday_open|escape:'htmlall':'UTF-8'}{/if}"/>

                        <input type="hidden" class="Vs_Close" name="VS_Sunday_close" data-index="1" value="{if $form_value.VS_day_check_Sunday}{$form_value.VS_Sunday_close|escape:'htmlall':'UTF-8'}{/if}"/>

                </div>

            </div>

            </div>

            <div class="panel-heading" style="margin:50px 0px 20px 0px;">

                <i class="icon-envelope"></i> {l s='Messages Us button-:' mod='vsmessangercustomerchat'}

            </div>

            <div class="form-group">

                <label class="control-label col-lg-3" for="VS_fb_appid">

                <strong>{l s='App Id' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-9">

                    <input type="text" name="VS_fb_appid" id="VS_fb_appid" value="{if $form_value.VS_fb_appid}{$form_value.VS_fb_appid|escape:'htmlall':'UTF-8'}{/if}" />

                    <p class="help-block">

                        {l s='Enter your facebook AppID check Instruction ' mod='vsmessangercustomerchat'}

                        <a href="https://vsteq.com/to-get-facebook-app-id/" target="_blank">{l s='here.' mod='vsmessangercustomerchat'}</a>

                    </p>

                </div>

            </div>

            

            <div class="form-group">

                <label for="VSEnable_send_us_message" class="control-label col-lg-3">

                    <strong>{l s='Enable send us message' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-9">

                    <span class="switch prestashop-switch fixed-width-lg">

                        <input type="radio" name="VSEnable_send_us_message" id="VSEnable_send_us_message_on" value="1" {if $form_value.VSEnable_send_us_message == 1}checked="checked"{/if}>

                        <label for="VSEnable_send_us_message_on" class="radioCheck">Yes</label>

                        <input type="radio" name="VSEnable_send_us_message" id="VSEnable_send_us_message_off" value="0" {if $form_value.VSEnable_send_us_message == 0}checked="checked"{/if}>

                        <label for="VSEnable_send_us_message_off" class="radioCheck">No</label>

                        <a class="slide-button btn"></a>

                    </span>

                    <div class="clearfix"></div>

                    <p class="help-block">{l s='Enable send us a message button while you are not available.' mod='vsmessangercustomerchat'}</p>

                </div>

            </div>

            

            <div class="form-group">

                <label class="control-label col-lg-3" for="VS_button_color">

                <strong>{l s='Select color of button' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-9">

                    <select class="VS_button_color col-lg-4" name="VS_button_color" id="VS_button_color">

                        <option value="blue" {if $form_value.VS_button_color=='blue'}selected="selected"{/if}>{l s='Blue' mod='vsmessangercustomerchat'}</option>

                        <option value="white" {if $form_value.VS_button_color=='white'}selected="selected"{/if}>{l s='White' mod='vsmessangercustomerchat'}</option>

                    </select>

                </div>

            </div>

            

            <div class="form-group">

                <label class="control-label col-lg-3" for="VS_size_of_button">

                <strong>{l s='Select size of button' mod='vsmessangercustomerchat'}</strong>

                </label>

                <div class="col-lg-9">

                    <select class="VS_size_of_button col-lg-4" name="VS_size_of_button" id="VS_size_of_button">

                        <option value="large" {if $form_value.VS_size_of_button=='large'}selected="selected"{/if}>{l s='Large' mod='vsmessangercustomerchat'}</option>

                        <option value="xlarge" {if $form_value.VS_size_of_button=='xlarge'}selected="selected"{/if}>{l s='Xlarge' mod='vsmessangercustomerchat'}</option>

                        <option value="standard" {if $form_value.VS_size_of_button=='standard'}selected="selected"{/if}>{l s='Standard' mod='vsmessangercustomerchat'}</option>

                    </select>

                </div>

            </div>



        </div>

    </div>

    <div class="panel-footer">

        <button type="submit" value="1" id="Save_Messenger_Customer_Live_Chat" name="Save_Messenger_Customer_Live_Chat" class="btn btn-default pull-right">

            <i class="process-icon-save"></i> Save

        </button>

    </div>

    </form>

</div>
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

{if isset($configData) && $configData.VSLIVECHAT_LIVE_MODE}

		<style>
			.fb_dialog{
			{if $configData.VS_position == 'right' }right: {$configData.VS_right_padding|escape:'htmlall':'UTF-8'}px!important;{/if}			
			{if $configData.VS_position == 'left' }left: {$configData.VS_left_padding|escape:'htmlall':'UTF-8'}px!important;{/if}
			{if $configData.VS_position == 'Default' }right: {$configData.VS_right_padding|escape:'htmlall':'UTF-8'}px!important;{/if}
			}		
			.fb-customerchat{
			{if $configData.VS_position == 'right' }right: {$configData.VS_right_padding|escape:'htmlall':'UTF-8'}px!important;{/if}
			{if $configData.VS_position == 'left' }left: {$configData.VS_left_padding|escape:'htmlall':'UTF-8'}px!important;{/if}
			{if $configData.VS_position == 'Default' }right: {$configData.VS_right_padding|escape:'htmlall':'UTF-8'}px!important;{/if}
			}
			.fb_customer_chat_bounce_in_v2{
			{if $configData.VS_position == 'right' }right: {$configData.VS_right_padding|escape:'htmlall':'UTF-8'}px!important;{/if}
			{if $configData.VS_position == 'left' }left: {$configData.VS_left_padding|escape:'htmlall':'UTF-8'}px!important;{/if}
			{if $configData.VS_position == 'Default' }right: {$configData.VS_right_padding|escape:'htmlall':'UTF-8'}px!important;{/if}
			}
			.fb_customer_chat_bounce_out_v2{
			{if $configData.VS_position == 'right' }right: {$configData.VS_right_padding|escape:'htmlall':'UTF-8'}px!important;{/if}
			{if $configData.VS_position == 'left' }left: {$configData.VS_left_padding|escape:'htmlall':'UTF-8'}px!important;{/if}
			{if $configData.VS_position == 'Default' }right: {$configData.VS_right_padding|escape:'htmlall':'UTF-8'}px!important;{/if}
			}
			@keyframes fb_bounce_in_v2{
			{if $configData.VS_position == 'right' }0%{	opacity:0;
													transform:scale(0, 0);												
													transform-origin:bottom right;
													}{/if}
			{if $configData.VS_position == 'right' }50%{ transform:scale(1.03, 1.03);													
													transform-origin:bottom right;
													}{/if}
			{if $configData.VS_position == 'right' }100%{ opacity:1;
													transform:scale(1, 1);													
													transform-origin:bottom right;
													}{/if}
			{if $configData.VS_position == 'Default' }0%{	opacity:0;
													transform:scale(0, 0);												
													transform-origin:bottom right;
													}{/if}
			{if $configData.VS_position == 'Default' }50%{ transform:scale(1.03, 1.03);													
													transform-origin:bottom right;
													}{/if}
			{if $configData.VS_position == 'Default' }100%{ opacity:1;
													transform:scale(1, 1);													
													transform-origin:bottom right;
													}{/if}													
			{if $configData.VS_position == 'left' }0%{ opacity:0;
													transform:scale(0, 0);													
													transform-origin:bottom left;
													}{/if}	
			{if $configData.VS_position == 'left' }50%{	transform:scale(1.03, 1.03);												
													transform-origin:bottom left;
													}{/if}	
			{if $configData.VS_position == 'left' }100%{ opacity:1;
													transform:scale(1, 1);														
													transform-origin:bottom left;
													}{/if}
			}
			@keyframes fb_bounce_out_v2{
			{if $configData.VS_position == 'right' }0%{ opacity:1;
													transform:scale(1, 1);													
													transform-origin:bottom right;
													}{/if}
			{if $configData.VS_position == 'right' }100%{ opacity:0;
													transform:scale(0, 0);												
													transform-origin:bottom right;
													}{/if}	
			{if $configData.VS_position == 'left' }0%{ opacity:1;
													transform:scale(1, 1);														
													transform-origin:bottom left;
													}{/if}													
			{if $configData.VS_position == 'left' }100%{ opacity:0;
													transform:scale(0, 0);														
													transform-origin:bottom left;
													}{/if}
			{if $configData.VS_position == 'Default' }0%{ opacity:1;
													transform:scale(1, 1);													
													transform-origin:bottom right;
													}{/if}
			{if $configData.VS_position == 'Default' }100%{ opacity:0;
													transform:scale(0, 0);												
													transform-origin:bottom right;
													}{/if}											
			}
		</style> 

        <script>(function(d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            js = d.createElement(s); js.id = id;
            js.src = 'https://connect.facebook.net/{$lang|escape:"htmlall":"UTF-8"}/sdk/xfbml.customerchat.js#xfbml=1&version=v2.12&autoLogAppEvents=1';
            fjs.parentNode.insertBefore(js, fjs);
          }(document, 'script', 'facebook-jssdk'));</script>
    {if $Send_message == 1}
        <div class="fb-messengermessageus" 
          messenger_app_id="{$configData.VS_fb_appid|escape:'htmlall':'UTF-8'}" 
          page_id="{$configData.VS_fb_page_id|escape:'htmlall':'UTF-8'}"
          color="{$configData.VS_button_color|escape:'htmlall':'UTF-8'}"
          size="{$configData.VS_size_of_button|escape:'htmlall':'UTF-8'}"></div>
    {else}
        <div id='fb-root'></div>
    
        <div class='fb-customerchat'
            page_id='{$configData.VS_fb_page_id|escape:"htmlall":"UTF-8"}'
            logged_in_greeting='{$configData.VS_greeting_message_in|escape:"htmlall":"UTF-8"}'
            logged_out_greeting='{$configData.VS_greeting_message_out|escape:"htmlall":"UTF-8"}'			
            {if $configData.VS_theme_color }
			theme_color='{$configData.VS_theme_color|escape:"htmlall":"UTF-8"}'
			{/if}
			{if $configData.VS_greeting_dialog_display }
            greeting_dialog_display='{$configData.VS_greeting_dialog_display|lower|escape:"htmlall":"UTF-8"}'
			{/if}			
			{if $configData.VS_auto_open_delay }
            greeting_dialog_delay ='{$configData.VS_auto_open_delay|escape:"htmlall":"UTF-8"}'
			{/if}			
		>
        </div>
    {/if}
{/if}

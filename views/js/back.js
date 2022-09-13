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
*
* Don't forget to prefix your containers with your own identifier
* to avoid any conflicts with others containers.
*/

function vs_setupCustomerChat() {
  const FACEBOOK_URL = "https://www.facebook.com";
  var baseURL = "https://www.facebook.com/customer_chat/dialog/?domain=";
  var urlParam = encodeURI(
    window.location.protocol
      + '//'
      + window.location.hostname
      + (window.location.port ? ':' + window.location.port : '')
  );
  var customerWindow = window.open(
    baseURL + urlParam,
    "_blank",
    "width=1200,height=750"
  );

  jQuery(window).on("message", function(e) {
    if (e.originalEvent.origin === FACEBOOK_URL) {
      $data_json = JSON.parse(e.originalEvent.data);
       console.log($data_json);
       var vsajaxurl = $('#controllerurl').val();
       var redirecthref = $('#redirecthref').val();
       //alert(vsajaxurl);
      var data = {
        'ajax': true,
        'action' : 'update_options',
        'pageID' : vs_sanitizeNumbersOnly($data_json["pageID"]),
        'locale' : vs_sanitizeLocale($data_json["locale"]),
        'themeColor' : vs_sanitizeHexColor($data_json["themeColorCode"]),
        'greetingText' : $data_json["greetingTextCode"],
      };
     
      
      jQuery.ajax({
        type: 'POST',
        dataType: 'JSON',
        url: vsajaxurl,
        data: data,
        success: function(results) {
			sessionStorage.setItem('save_configuration',true);
			window.location.href = redirecthref;
			//window.location.reload();
			//console.log(results);
        },
        error: function(err) {
            //console.log(err);
            //console.log(vsajaxurl);
        },
      });
    }
  });
}
function vs_sanitizeNumbersOnly( number ) {
  if( /^\d+$/.test(number) ) {
    return number;
  } else {
    return '';
  }
}

function vs_sanitizeLocale( locale ) {
  if( /^[A-Za-z_]{4,5}$/.test(locale) ) {
    return locale;
  } else {
    return '';
  }
}

function vs_sanitizeHexColor( color ) {
  if( /^#([A-Fa-f0-9]{3}){1,2}$/.test(color) ) {
    return color;
  } else {
    return null;
  }
}

$(document).ready(function() {
    if ( sessionStorage.getItem('save_configuration') ) {
		var config_succ = '<div class="alert alert-success success">Configuration update successfully.</div>';
		document.getElementById("config_msg").innerHTML = config_succ;
		sessionStorage.removeItem('save_configuration');
	}
	
	$(".sliders").each(function() {
        var this_obj = $(this);
        var id = $(".slider", this_obj).attr('id');
        //alert(id);
        //console.log(this_obj);
        var Open = 0; //540
        var Close = 0; //1020
        var Vs_Open = $(".Vs_Open", this_obj).val();
        var Vs_Close = $(".Vs_Close", this_obj).val();
        //alert('Open : '+Vs_Open+' Close : '+Vs_Close);
        if (Vs_Open !== '' && Vs_Close !== '') {
            Open = Vs_Open;
            Close = Vs_Close;
        }
        setOpenClose(this_obj, Open, Close);
        call_sliders(id, this_obj, Open, Close);
    });
    
    function call_sliders(id, this_obj, Open, Close) {
        $("#"+id, this_obj).slider({
            range: true,
            orientation: "horizontal",
            min: 0,
            max: 1440,
            step: 15,
            values: [Open, Close],
            slide: function(event, ui) {
                setOpenClose($(this), ui.values[0], ui.values[1]);
            }
        });
    }
    
    function setOpenClose(this_obj, Open, Close) {
        var openh = Math.floor(Open / 60);
        var openm = Open - (openh * 60);

        if (openh.length == 1) openh = '0' + openh;
        if (openm.length == 1) openm = '0' + openm;
        if (openm == 0) openm = '00';
        if (openh >= 12) {
            if (openh == 12) {
                openh = openh;
                openm = openm + " PM";
            } else {
                openh = openh - 12;
                openm = openm + " PM";
            }
        } else {
            openh = openh;
            openm = openm + " AM";
        }
        if (openh == 0) {
            openh = 12;
            openm = openm;
        }
        
        var closeh = Math.floor(Close / 60);
        var closem = Close - (closeh * 60);

        if (closeh.length == 1) closeh = '0' + closeh;
        if (closem.length == 1) closem = '0' + closem;
        if (closem == 0) closem = '00';
        if (closeh >= 12) {
            if (closeh == 12) {
                closeh = closeh;
                closem = closem + " PM";
            } else if (closeh == 24) {
                closeh = 11;
                closem = "59 PM";
            } else {
                closeh = closeh - 12;
                closem = closem + " PM";
            }
        } else {
            closeh = closeh;
            closem = closem + " AM";
        }
        
        this_obj.parent().children(".range").text(openh+':'+openm+" - "+closeh+':'+closem);
        if (Open == '' && Close == '') {
            $(".range", this_obj).text('Closed');
            this_obj.parent().children(".Vs_Open").val('');
            this_obj.parent().children(".Vs_Close").val('');
        } else {
            $(".range", this_obj).text(openh + ':' + openm + " - " + closeh + ':' + closem);
            this_obj.parent().children(".Vs_Open").val(Open);
            this_obj.parent().children(".Vs_Close").val(Close);
        }
    }
    
    
    
    $('#VS_login_greeting_message_lang').change(function(){
        var lang_id = $(this).val();
        var list = $('#VS_login_greeting_message_lang option');
        $.map(list, function(elt, i) {
            //return $(elt).val();
            if (lang_id == $(elt).val()) {
                //$('#vs_greeting_message_in'+lang_id).prop('disabled', false);
                $('#vs_greeting_message_in'+lang_id).show();
            } else {
                //$('#vs_greeting_message_in'+$(elt).val()).prop('disabled', true);
                $('#vs_greeting_message_in'+$(elt).val()).hide();
            }
        });
    });
    
    $('#VS_logout_greeting_message_lang').change(function(){
        var lang_id = $(this).val();
        var list = $('#VS_logout_greeting_message_lang option');
        $.map(list, function(elt, i) {
            //return $(elt).val();
            if (lang_id == $(elt).val()) {
                //$('#vs_greeting_message_out'+lang_id).prop('disabled', false);
                $('#vs_greeting_message_out'+lang_id).show();
            } else {
                //$('#vs_greeting_message_out'+$(elt).val()).prop('disabled', true);
                $('#vs_greeting_message_out'+$(elt).val()).hide();
            }
        });
    });		
	
	$('#VS_position').on('change', function() {
	  // alert( this.value ); // or $(this).val()
	  if(this.value == "left") {
		 $('#VS_left_padding_form').show();
		$('#VS_right_padding_form').hide(); 		
	  }
	  if(this.value == "right") {
		$('#VS_right_padding_form').show();
		$('#VS_left_padding_form').hide();
	  }
	  if(this.value == "Default") {
		$('#VS_right_padding_form').hide();
		$('#VS_left_padding_form').hide();
	  }
	});
});


/*
 * Buddhist Era ( BE. ) Plugins for jQuery UI Datepicker
 * Version 0.2 Alpha
 * Copyright 2011, Sorajate Maiprasert  ( Sorajate @ gmail.com )
 * Licensed under GPL Version 2 license.
 * Tested On Datepicker V 1.8.13
 * Depends:
 *	jquery.ui.datepicker.js
 * Usage:
 * - To Enable Buddhist Era  set option iSBE to true
 * - To Enable Auto Conversion hidden field set autoConversionField to true ( it is true by default if isBE is true )
 */
(function($){
    //Proxy Pattern
    var d_showDatepicker = $.datepicker._showDatepicker;
    var d_selectDay = $.datepicker._selectDay;
    var d_selectDate = $.datepicker._selectDate;
    var d_attachDatepicker = $.datepicker._attachDatepicker;
    var d_adjustInstDate = $.datepicker._adjustInstDate;
    var d_inlineDatepicker = $.datepicker._inlineDatepicker;
    var d_setDate = $.datepicker._setDate;
    var d_updateDatepicker = $.datepicker._updateDatepicker;
    var d_generateHTML = $.datepicker._generateHTML;
    var d_generateMonthYearHeader = $.datepicker._generateMonthYearHeader;

    //Insert default parameter to datepicker
    $.extend($.datepicker._defaults, {
        isBE:false,
        autoConversionField:true
    });

    $.extend($.datepicker, {
        _attachBE: function () {
            $.extend($.datepicker._defaults, {
                 beforeShow : function(){  }
            });

        },

        _selectDate: function(id, dateStr){
            d_selectDate.apply(this,arguments);
        },

        /*Override methods*/
        _attachDatepicker: function(target, settings) {
            d_attachDatepicker.apply(this,arguments);
            var autoConvert =  (typeof(settings.autoConversionField) !== 'undefined' && settings.autoConversionField != null) ? settings.autoConversionField : true;
            var _isBE = (typeof(settings.isBE) !== 'undefined' && settings.isBE != null) ? settings.isBE : false;
            var _isInput = $(target).is("input")
            if(autoConvert == true && _isBE == true && _isInput == true){  //Only for input for now
                $.datepicker._attachConversion(target);
            }

        },

        _attachConversion : function(target){
            var _name = $(target).attr('name');
            var _id = $(target).attr('id');
            var convertId = _id +"_convert";
            $(target).parent().append('<input type="hidden" rel="'+_id+'" id="'+convertId+'" name="'+_name+'" />');
            //change original name
            $(target).attr('name',convertId);
        },

        _adjustInstDate: function(inst, offset, period) {
            var _isBE = (typeof(inst.settings.isBE) !== 'undefined' && inst.settings.isBE != null) ? inst.settings.isBE : false;
            if(_isBE == true){
                //Change drawYear back to CE after it got parse                               
                inst.drawYear = $.datepicker._convertToCe(inst.drawYear);

            }
            d_adjustInstDate.apply(this,arguments);
	    },

        _selectDay: function(id, month, year, td) {
            //need the instance
            var target = $(id);
		        if ($(td).hasClass(this._unselectableClass) || this._isDisabledDatepicker(target[0])) {
			    return;
		    }
            var _inst = this._getInst(target[0]);
            var _isBE = (typeof(_inst.settings.isBE) !== 'undefined' && _inst.settings.isBE != null) ? _inst.settings.isBE : false;
            var autoConvert = (typeof(_inst.settings.autoConversionField) !== 'undefined' && _inst.settings.autoConversionField != null) ? _inst.settings.autoConversionField : true;
            var d_year = $.datepicker._convertToCe(year);

            if(_isBE == true  ){ //Fire only when isBE
                year = $.datepicker._convertToBe(year);
            }

            d_selectDay.apply(this,arguments);
            //Restore value
            //_inst.selectedYear = _inst.currentYear = _inst.drawYear =  d_year;
            _inst.currentYear = $.datepicker._convertToCe(_inst.currentYear);
            _inst.drawYear = $.datepicker._convertToCe(_inst.drawYear);
            _inst.selectedYear = $.datepicker._convertToCe(_inst.selectedYear);
            if(autoConvert == true && _isBE == true){
                //Parse value to child element
                var childName = target.attr('name');
                var childId = '#' + childName;
                var childValue = this._formatDate(_inst,_inst.currentDay, _inst.currentMonth, d_year);
                $(childId).val(childValue);
            }
        },

        _showDatepicker : function(input){
            var _inst = $.datepicker._getInst(this);
            var _isBE = $.datepicker._isBE(_inst);

			//Datetimepicker Compatible
			if(jQuery.timepicker && _isBE == true){
				var tp_inst = $.datepicker._get(_inst, 'timepicker');
				if(tp_inst){
					var tp_updateDateTime = tp_inst._updateDateTime;
					$.extend(_inst.settings.timepicker,{
						_updateDateTime : function(dp_inst){
							dp_inst = _inst || dp_inst,
							dp_inst.selectedYear = $.datepicker._convertToBe(dp_inst.selectedYear);
							tp_updateDateTime.apply(this,arguments);
							//Restore after finish use
							dp_inst.selectedYear = $.datepicker._convertToCe(dp_inst.selectedYear);

						}
					});
				}
			}

            if(_isBE == true){ //Fire only when isBE
                $.datepicker._SetBEDisplay(_inst);
            }
            
            d_showDatepicker.apply(this,arguments);
        },

        _inlineDatepicker: function(target, inst) {
            d_inlineDatepicker.apply(this,arguments);
        },

        _generateMonthYearHeader: function(inst, drawMonth, drawYear, minDate, maxDate,
			secondary, monthNames, monthNamesShort) {

            var _isBE = $.datepicker._isBE(inst);

            if(_isBE == true){
                drawYear = $.datepicker._convertToBe(drawYear);
            }
            
            return d_generateMonthYearHeader.apply(this,arguments);


        },

        _updateDatepicker: function(inst) {
            var _inst = inst;
            var _isBE = (typeof(_inst.settings.isBE) !== 'undefined' && _inst.settings.isBE != null) ? _inst.settings.isBE : false;
            d_updateDatepicker.apply(this,arguments);

            if(_isBE == true){ //Fire only when isBE
                $.datepicker._SetBEDisplay(_inst);
            }

        },

        _setDate: function(inst, date, noChange) {
            d_setDate.apply(this,arguments);            
        },

        _generateHTML: function(inst) {
            var _isBE = (typeof(inst.settings.isBE) !== 'undefined' && inst.settings.isBE != null) ? inst.settings.isBE : false;
            if(_isBE){
                //This will restore the selected
                if(inst.currentYear != 0){
                    inst.currentYear = $.datepicker._convertToCe(inst.currentYear);
                }
            }
            var result =  d_generateHTML.apply(this,arguments);
            //Restore value
            if(_isBE){
                inst.currentYear = $.datepicker._convertToCe(inst.currentYear);
                inst.drawYear = $.datepicker._convertToCe(inst.drawYear);
                inst.selectedYear = $.datepicker._convertToCe(inst.selectedYear);
            }
            return result;
        },

        _SetBEDisplay: function(inst){
            var _inst = inst;
            var element = _inst.inline == true ? _inst.dpDiv : _inst.dpDiv[0];
            var drawYear = _inst.drawYear;
            if(drawYear == 0){
                drawYear = _inst.currentYear;
            }
            drawYear = $.datepicker._convertToCe(drawYear);
            var selectedYear = _inst.selectedYear = _inst.currentYear = _inst.drawYear = $.datepicker._convertToCe(inst.selectedYear);
            
            if(selectedYear == 0){
                selectedYear = new Date().getFullYear();
            }
            var yF =  $(element).find( '.ui-datepicker-year' );
			
                var domEl = $(yF).get(0);				
				
				if(!domEl){
					return false;
				}
				
                if(typeof(domEl.tagName) !== 'undefined' && domEl.tagName != null){
                    switch(domEl.tagName){
                        case "SELECT" :  //Change all value
                                $(domEl).children('option').each(function(){
                                    $(this).text($.datepicker._convertToBe($(this).val()));
                                    var _year = $(this).val();
                                    if(_year == drawYear){
                                        $(this).attr('selected','selected');
                                    }

                                });
                        break;
                        case "SPAN" :
                                //Use generate month header instead
                        break;
                        default :
                            //console.log(domEl.tagName);
                        break;
                    }
                }
            
        },

        _isBE : function (inst){
            var _isBE = (typeof(inst.settings.isBE) !== 'undefined' && inst.settings.isBE != null) ? inst.settings.isBE : false;
            return _isBE;
        },

        _convertToBe : function(year){
            if((parseInt(year) - 543) < 1900  ){
                return parseInt(year) + 543;
            }else{
                return year;
            }
        },

        _convertToCe : function(year){
            if((parseInt(year) - 543) >= 1900  ){
                return parseInt(year) - 543;
            }else{
                return year;
            }
        }



    });

})(jQuery); 
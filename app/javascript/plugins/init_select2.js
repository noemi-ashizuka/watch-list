import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.select2').select2({
    dropdownParent: $("#bookmark_form")
  });
};

export { initSelect2 };
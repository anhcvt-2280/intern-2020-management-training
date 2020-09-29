import {customAlert} from "../../packs/trainer/subject";

$(document).on('turbolinks:load', function (){
  $('#wrap-comment').on('click', '.btn-reply', function (){
    $(this).parent().siblings('#wrap-form-reply').toggle();
  });

  $('#wrap-comment').on('click', '.btn-delete-cmt', function(event) {
    event.preventDefault();
    let url = $(this).data('url');
    let id = $(this).data('cmt');
    let cmtElement = $(this).parents(`#cmt-${id}`);
    Swal.fire({
      title: I18n.t('js.notice.confirm_title'),
      text: I18n.t('js.notice.confirm_text'),
      showCancelButton: true,
      icon: 'warning',
      confirmButtonText: I18n.t('js.notice.btn_confirm'),
      cancelButtonText: I18n.t('js.notice.btn_cancel')
    }).then((result) => {
      if (result.value) {
        $.ajax({
          url: url,
          type: 'delete',
          success: function(data) {
            if (data.success) {
              customAlert('sc');
              cmtElement.remove();
            } else {
              customAlert('err');
            }
          },
          error: function(data) {
            customAlert('err');
          }
        });
      }
    })
  });
});

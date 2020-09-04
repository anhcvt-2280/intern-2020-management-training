import {customAlert} from "../../packs/trainer/subject";

$(document).on('turbolinks:load', function () {
  //Config Ajax
  $.ajaxSetup({
    headers:
      {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')}
  });
  // End Config Ajax

  // Feature checkbox all
  let checkAll = $('#check-all');
  checkAll.on('change', function () {
    let listSubjects = $('#list-subjects input[type="checkbox"]');
    if ($(this).prop('checked')) {
      listSubjects.each(function (index, element) {
        $(element).prop('checked', true);
        $(element).next().val($(element).data('id'));
      })
    } else {
      listSubjects.each(function (index, element) {
        $(element).prop('checked', false);
        $(element).next().val(null);
      })
    }
    updatePrioritySubject();
  });
  // End Feature checkbox all

  // Topic and Subject
  let urlSearchSubject = $('#search-subject').data('url');
  $('#search-subject').on('click', function () {
    let topicId = '';
    let listSubject = [];

    $('#topic option').each(function (index, element) {
      if ($(element).prop('selected')) {
        topicId = $(element).val();
        return false;
      }
    });

    $('#list-subjects input[type="checkbox"]').each(function (index, element) {
      if($(element).prop('checked')) listSubject.push($(element).val());
    });

    if($('#list-subjects input[type="hidden"]').length > 0) {
      $('#list-subjects input[type="hidden"]').each(function (index, element) {
        if($(element).val()) listSubject.push($(element).val());
      });
    }

    $.ajax({
      url: urlSearchSubject,
      method: 'GET',
      data: {
        topic: getTopic(),
        ids: getSubjects()
      }
    });
  });

  $('#searchSubject').on('keydown', function (e) {
    if (e.which === 13) {
      let keyword = $(this).val();
      let topicId = '';
      $('#topic option').each(function (index, element) {
        if ($(element).prop('selected')) {
          topicId = $(element).val();
          return false;
        }
      });

      $.ajax({
        url: urlSearchSubject,
        method: 'GET',
        data: {
          query: keyword,
          topic: getTopic(),
          ids: getSubjects()
        }
      });
    }
  });

  function getTopic() {
    let topicId = '';
    $('#topic option').each(function (index, element) {
      if ($(element).prop('selected')) {
        topicId = $(element).val();
        return false;
      }
    });
    return topicId;
  }

  function getSubjects() {
    let listSubject = [];
    $('#list-subjects input[type="checkbox"]').each(function (index, element) {
      listSubject.push($(element).data('id'));
    });

    $('#list-subjects input.subject').each(function (index, element) {
      listSubject.push($(element).val());
    });

    return listSubject;
  }

  $('#add-subject').on('click', function () {
    $('#other-list-subjects li').each(function (index, element) {
      if ($(element).children('input[type="checkbox"]').prop('checked')) {
        let btn_delete = '<button class="btn btn-danger delete-subject-new mt-3"><i class="fas fa-trash-alt"></i></button>';
        $(element).clone().append(btn_delete).appendTo('#list-subjects');
        $(element).remove();
        updatePrioritySubject();
      }
    });
  });

  $('.wrap-topic').on('click', '.delete-subject', function (e) {
    e.preventDefault();
    let inputDelete = $(this).siblings('input#subject-hidden')
    if(inputDelete) inputDelete.val(1);
    $(this).parent('li').hide();
  });

  $('.wrap-topic').on('click', '.delete-subject-new', function (e) {
    e.preventDefault();
    $(this).parent('li').remove();
  });
  //End Subject and Topic

  // Search Trainee
  let urlSearchTrainee = $('#btn-search-trainee').data('url');
  $('#searchTrainee').on('keydown', function (e) {
    if (e.which === 13) {
      let keyword = $(this).val();
      let ids = [];

      $('#list-trainee-added input.trainees').each(function (index, element) {
        if($(element).val()) ids.push($(element).val())
      });

      $.ajax({
        url: urlSearchTrainee,
        method: 'GET',
        data: {
          query: keyword,
          ids: ids
        }
      });
    }
  });
  //End Search Trainee

  //Add trainee
  $('#list-trainee').on('click', 'li',function (element) {
    let btn_delete = '<button class="btn btn-danger delete-trainee-new mt-3"><i class="fas fa-trash-alt"></i></button>';
    $(this).append(btn_delete);
    $('#list-trainee-added').append($(this));
  });

  $('.wrap-trainee').on('click', '.delete-trainee', function (e) {
    e.preventDefault();
    let inputDelete = $(this).siblings('input#trainee-hidden')
    if(inputDelete) inputDelete.val(1);
    $(this).parent('li').hide();
  });

  $('.wrap-trainee').on('click', '.delete-trainee-new', function (e) {
    e.preventDefault();
    $(this).parent('li').remove();
  });
  //End Trainee

  $('body').on('change', '.select-subject', function () {
    if($(this).prop('checked')) {
      $(this).next().val($(this).data('id'));
    } else {
      $(this).next().val(null);
    }
    updatePrioritySubject();
  });

  //End trainee

  // Preview image

  function readURL(input) {
    if (input.files && input.files[0]) {
      let reader = new FileReader();

      reader.onload = function(e) {
        $('#img-preview').attr('src', e.target.result);
      }

      reader.readAsDataURL(input.files[0]);
      $('#img-preview').css('display', 'block');
    }
  }

  $('#course_image').on('change', function() {
    readURL(this);
  });

  // End preview image

  //Feature Priority
  $('#list-subjects').sortable({
    update: function (event, ui) {
      updatePrioritySubject();
    }
  });

  function updatePrioritySubject() {
    $('#list-subjects input.subject-priority').each(function (index, element) {
      $(element).val(index);
    });
  }
  // End Feature Priority

  // Delete course
  $('#delete-course').on('click', function(event) {
    event.preventDefault();
    let url = $(this).data('url');
    Swal.fire({
      title: I18n.t('js.trainer.subject.d_confirm_title'),
      text: I18n.t('js.trainer.subject.d_confirm_text'),
      showCancelButton: true,
      icon: 'warning',
      confirmButtonText: I18n.t('js.trainer.subject.d_btn_confirm'),
      cancelButtonText: I18n.t('js.trainer.subject.d_btn_cancel')
    }).then((result) => {
      if (result.value) {
        $.ajax({
          url: url,
          type: 'delete'
        });
      }
    })
  });
  // End delete course
});

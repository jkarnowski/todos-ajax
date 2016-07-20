$(document).ready(function() {
  console.log('READY');
  getNewTodosForm();
  postNewTodo();
});

function getNewTodosForm() {
  $('#new-todo-form').on('click', function(event){
    event.preventDefault();

    $.ajax({
      url: '/todos/new',
      method: 'GET'
    })
    .done(function(serverData){
      // hide the link for a new form
      $('#new-todo-form').hide();
      // show the form
      $('#new-todo').append(serverData);
    })
    .fail(function(serverData){
      console.log('failing');
    })
  })
};

function postNewTodo(){
  // element that is listening for an event: $('#new-todo')
  // event that happens: submit
  // passing in a child DOM element of the element w the event listener: 'form'
  $('#new-todo').on('submit', 'form', function(event){
    event.preventDefault();
    // grabs the data from the form
    var formData = $(this).serialize();
    // resets the input fields in the form
    $('input[type="text"]').val('')

    $.ajax({
      url: '/todos',
      method: 'POST',
      data: formData
    })
    .done(function(serverData){
      console.log('SUCCESS', serverData)
      $('.todos').prepend(serverData);
    })
    .fail(function(serverData){
      console.log('FAILING')
    })
  })
}














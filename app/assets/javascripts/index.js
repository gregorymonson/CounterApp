

$(document).ready(function(){
  $('#countScreen').hide();
  $('#logoutScreen').hide();
  $('#message').html('Please enter your username and password, or create a new account')

  $('#loginButton').click(function(e){
    e.preventDefault();
    var username = $('#username').val();
    var password = $('#password').val();
    $.ajax({
      type: 'POST',
      url: '/users/login',
      data: JSON.stringify(
        {user_name: username, password: password}),
      contentType: 'application/json',
      dataType: 'json',
      success: function(data){
        displayCountScreen(data);
      }
    });
  });

  $('#logoutButton').click(function(e) {
  });

  $('#registerButton').click(function(e){
    e.preventDefault();
    var username = $('#username').val();
    var password = $('#password').val();
    $.ajax({
      type: 'POST',
      url: '/users/add',
      data: JSON.stringify(
        {user_name: username, password: password}),
      contentType: 'application/json',
      dataType: 'json',
      success: function(data){
        displayCountScreen(data);
      }
    });
  });
});

function successfulLogin(count, username) {
  $('#message').html('');
  $('.name').html(username);
  $('.count').html(count);
  $('#loginScreen').hide();
  $('#logoutScreen').show();
  $('#countScreen').show();
}

function unsuccessfulLogin(errCode) {
  clear();
  
  if (errCode == -1) {
    $('#message').html('Incorrect username or password');
  } else if (errCode == -2) {
    $('#message').html('This username has already been taken');
  } else if (errCode == -3) {
    $('#message').html('Username is not valid');
  } else if (errCode == -4) {
    $('#message').html('Password is not valid');
  } else {
    $('#message').html('There is an unexpected error. Please try again later');
  }
}

function clear(){
  document.getElementById("username").value="";
  document.getElementById("password").value="";
}

function displayCountScreen(data) {
  var errCode = data['errCode'];
  var username = $('#username').val();
  if (errCode == 1) {
    var count = data['count'];
    successfulLogin(count, username)
  } else {
    unsuccessfulLogin(errCode)
  }
}



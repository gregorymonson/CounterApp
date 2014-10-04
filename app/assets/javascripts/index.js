
//Initialize page
$(document).ready(function(){
  $('#countScreen').hide();
  $('#logoutScreen').hide();
  $('#message').html('Please enter your username and password, or create a new account')

  //Handle click on loginButton; 
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

  // Handle logoutButton by refreshing page
  $('#logoutButton').click(function(e) {
  });

  // Handle click on registerButton. On success, switch to countScreen screen. On failure, display error message
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

//Update values count and username values in countScreen, and hide/show the appropriate portions of page
function successfulLogin(count, username) {
  $('#message').html('');
  $('.name').html(username);
  $('.count').html(count);
  $('#loginScreen').hide();
  $('#logoutScreen').show();
  $('#countScreen').show();
}

//Display error message and clear textboxes in form
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

//Clear textboxes in form
function clear(){
  document.getElementById("username").value="";
  document.getElementById("password").value="";
}

// Display the appropriate screen based on user input
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



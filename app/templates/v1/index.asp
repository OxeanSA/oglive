<!doctype html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>{{ cxi.decrypt(username) }} </title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="#181516">
    <meta name="csrf-token" content="tf986yhbkbcmy65vvbc$&+f6544bb">
    <link rel="shotcut-icon" href="{{ url_for('static', filename='theme/icons/favicon.ico')}}">
    <link rel="manifest" href="{{ url_for('static', filename='etc/manifest/manifest.json') }}">
    <link rel="stylesheet" href="{{ url_for('static', filename='theme/@logged/home.css') }}">
    <link rel="stylesheet" href="{{ url_for('static', filename='theme/@logged/int/keyboard.css') }}">
    <link rel="stylesheet" href="{{ url_for('static', filename='theme/@thirdparty/fontawesome/css/fontawesome.min.css') }}">
    {{ turbo() }}
    <script src="{{ url_for('static', filename='etc/int/keyboard.js') }}" type="text/javascript"></script>
    <script src="{{ url_for('static', filename='net/base.js') }}" type="text/javascript"></script>
    <script src="{{ url_for('static', filename='etc/swipe.js') }}" type="text/javascript"></script>
  </head>
 <body data-swipe-threshold="100">
      <div data-turbo-permanent id='nav' class="mu-nav-top">
         <div data-turbo-permanent class="top-nav">
           <div data-turbo-permanent id="nwpost" onclick="nurl('upload', this)" class="fa fa-send"></div>
           <div data-turbo-permanent id="call" class="fa fa-phone"></div>
           <div data-turbo-permanent id="theme-toggle" onclick='wmode(this)' class="fa fa-sun-o"></div>
          	<div data-turbo-permanent id="search" onclick="swsrch()" class="fa fa-search"></div>
           <div data-turbo-permanent id="plogo" class="plogo">{% block title %} Céèra {% endblock %}</div>
           <div class='srch-cnt' id="srch-cnt">
              <input class='search-ipt' onclick="nurl('search', this)" placeholder='Search...'>
           </div>
           <div data-turbo-permanent class='ccont'>
              <div data-turbo-permanent id='c100' class="_72fik _it4vx"></div>
              <div data-turbo-permanent id='c20'></div>
           </div>
         </div>
         <turbo-frame>
           <div data-turbo-permanent id='nav-bottom' class="mu-nav-bottom">
              <div data-turbo-permanent onclick="nurl('home', this)" class="fa fa-home"></div>
              <div data-turbo-permanent onclick="nurl('users', this)" class="fa fa-users"></div>
              <div data-turbo-permanent onclick="nurl('messages', this)" class="fa fa-envelope"></div>
              <div data-turbo-permanent onclick="nurl('discover', this)" class="fa fa-globe"></div>
              <div data-turbo-permanent onclick="nurl('profile', this)" class="fa fa-user"></div>
           </div>
         </turbo-frame>
       </div>
    <div id="pg">
      <script>
        nurl("home", document.querySelector('.fa-home'));
      </script>
   </div>
 </body>
</html>

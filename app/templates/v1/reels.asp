{% set profile = conn.execute("SELECT profile FROM users WHERE id=='{}'".format(id)).fetchone()['profile'] %}
{% for post in posts %}
    {% set comments = conn.execute("SELECT * FROM comments LEFT JOIN users ON users.id=comments.uid WHERE post_id=='{}'".format(post['post_id'])).fetchall() %}
    {% set forwards = conn.execute("SELECT * FROM forwards LEFT JOIN users ON users.id=forwards.uid WHERE post_id=='{}'".format(post['post_id'])).fetchall() %}
    {% set username = post['firstname'] + ' ' + post['lastname'] %}
    {% set post_text = post['post_txt'] | replace(_tags("(#\w+)", post['post_txt']), "<font color='#89cff0'>{}</font>".format( _tags("(#\w+)", post['post_txt'])) | safe) %}
    {% set post_text = post_text | replace(_tags("(@\w+)", post_text), "<span id='atbold'>{}</span>".format( _tags("@(\w+)", post_text)) | safe) %}
    {% set post_pic = 'uploads/users/{}/posts/images/{}'.format(post['uid'], post['post_pic']) %}
    {% set post_profile = "uploads/users/{}/profiles/{}".format(post['uid'], post['profile']) %}
    {% set p_uprofile = "uploads/users/{}/profiles/{}".format(id, profile) %}
    {% set _path_i = url_for('static', filename='uploads/users/{}/posts/images/{}'.format(post['uid'], post['post_pic'])) %}
    {% set post_vid = url_for('static', filename='uploads/users/{}/posts/videos/{}'.format(post['uid'], post['post_vid'])) %}
    <div id="mu-post postid{{ post['post_id'] }}" class="mu-post">
      
      <div class="u-dtl">
         {% if post['profile'] == 'df' %}
            <img lazy=true class="post-u-media" src='assets/default.jpg'>
         {% else %}
            <img lazy=true class="post-u-media" src='http://{{ _ipaddr }}:8000/image?path={{ post_profile|replace("/", "cxit2") }}'>
         {% endif %}
         <div class="post-dropdown">
           <div onclick="drpmenu()" id="post-drpbtn">•••</div>
           <div id="myDropdown" class="post-dropdown-content">
             <div class='fa fa-download'> Save</div>
             <div class='fa fa-cloud-upload'> Repost</div>
             <div class='fa fa-share'> Share</div>
             <div class='fa fa-exclamation'> Unfollow {{ username }}</div>
           </div>
         </div>
         <div class="username">{{ username }}</div>
         {% if post['priority'] == 'public' %}
            <div class="p-date"><div class="p-date-ago">{{ _time(post['date']) }}</div><div class="dot"> • </div><div class="icn"><i class="fa fa-globe"></i></div>
            {% if post['mtag'] != None %}
               <div class="atu"><font color="#e5e5e5"><div class="dot"> • </div></font>{{ post['mtag'] }}</div>
            {% endif %}
         {% elif post['priority'] == 'ad' %}
            <div class="p-date">Sponsored <div class='dot'>•</div> ad</div>
         {% elif post['priority'] == 'private' %}
            <div class="p-date">Sponsored <div class='dot'>•</div> <i class='fa fa-lock'></i></div>
         {% endif %}
         </div>
       </div>
       {% if _path(_path_i) == True %}
         <div class="p-text">{{ post_text }}</div>
         <div class="p-media-cnt">
           <img id="p-media" lazy="true" src='http://{{ _ipaddr }}:8000/image?path={{ post_pic|replace("/", "cxit2") }}')' class="p-media">
         </div>
       {% elif _path(post_vid) == True %}
         <div class="p-text">{{ post_text }}</div>
         <div class="p-vid-cnt">
           <video class="p-vid" src="{{ url_for('video', path=post_vid|replace('/', 'cxit2')) }}"></video>
         </div>
       {% else %}
           <div class="p-text-bold">{{ post_text }}</div>
       {% endif %}
       <div id="pdots" onclick="prl(this)"><i class="fa fa-facebook"></i> 8    <i class="fa fa-instagram"></i> 3    <i class="fa fa-pinterest-p"></i> 7</div>
       {% if 1 >= 0 %}
          <div class="sn-like heart"><i class="fa fa-heart-pulse heart"></i></div>
          <div id="likes likesid{{ post['post_id'] }}" onload='likes(this)' class="p-likes">0</div>
       {% endif %}
       {% if comments|length > 0 %}
         <div class="p-comment"><i class="fa fa-comments"></i></div>
         <div class="p-comments">{{ comments|length }}</div>
       {% endif %}
       {% if forwards|length > 0 %}
         <div class="p-forward"><i class="fa fa-share"></i></div>
         <div class="p-forwards">{{ forwards|length }}</div>
       {% endif %}
       <div class="bottom-pst-ics">
          <div class="comment">
            {% if profile == 'df' %}
               <img class="profile" src='assets/default.jpg'>
            {% else %}
               <img class="profile" src="http://{{ _ipaddr }}:8000/image?path={{ p_uprofile|replace('/', 'cxit2') }}">   
            {% endif %}
            <input type="text" placeholder="Add a comment..." class="comment-ipt">
          </div>
       </div>
      
     </div>
  {% endfor %}
  <div class="br-line"></div>
  <div class='mre-posts'></div>
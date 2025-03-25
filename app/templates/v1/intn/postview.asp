<!-- EDIT LAYOUT! -->

{% for post in data %}
{% set post_text = post['post_text'] | replace(helpers._tags("(#\w+)", post['post_text']), "<font color='#89cff0' class='tagged-user'>{}</font>".format( helpers._tags("(#\w+)", post['post_text'])) | safe) %}
{% set post_text = post_text | replace(helpers._tags("(@\w+)", post_text), "<font color='#89cff0' class='tagged-user'>{}</font>".format( helpers._tags("@(\w+)", post_text)) | safe) %}
{% set likes = conn.execute("SELECT * FROM likes LEFT JOIN users ON users.user_id=likes.uid WHERE post_id=='{}'".format(post['post_id'])).fetchall() %}
{% set comments = conn.execute("SELECT * FROM comments LEFT JOIN users ON users.user_id=comments.uid WHERE post_id=='{}'".format(post['post_id'])).fetchall() %}
{% set forwards = conn.execute("SELECT * FROM forwards LEFT JOIN users ON users.user_id=forwards.uid WHERE post_id=='{}'".format(post['post_id'])).fetchall() %}
{% set username = post['firstname'] + ' ' + post['lastname'] %}
<div class="post-preview">
    <div class="mt-4"></div>
    <div id="post-cm" data-postid="{{ post['post_id'] }}" class="post-cm">
        <div class="imgpreview-header-top">
            <div class="bar-btn-gl onclick-blue" onclick="BackTo('home', 'useCache')">
                <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" height="28" viewBox="0 -960 960 960" width="29">
                    <path d="M560-240 320-480l240-240 56 56-184 184 184 184-56 56Z"/>
                </svg>
            </div>
        </div>
        <div class="post-preview-items">
            {% if post['post_type'] == "image" %} 
                <div class="post-preview-items-media-container">
                    <img class="post-preview-items-media" src="http://{{ _ipaddr }}:8000/image?uuid={{ post['uid'] }}&ppic={{ post['post_ul'] }}&ptp=post">
                    
                    <!-- EDIT: ADD AUTO TAGS 
                    <div class="post-preview-tags">
                        <div class="post-preview-tags-left"><i>oxeand.</i></div>
                        <div class="post-preview-test-left-vertical">•</div>
                        <div class="post-preview-tags-left"><i>asher</i></div>
                        <div class="post-preview-test-left-vertical">•</div>
                        <div class="post-preview-tags-left"><i>botstown</i></div>
                        <div class="post-preview-test-left-vertical">•</div>
                        <div class="post-preview-tags-left"><i>webtick</i></div>
                        <div class="post-preview-test-left-vertical">•</div>
                    </div>
                     ... -->

                    <div onlclick="showMenu('home-post-image', {postid: this.getAttribute('data-postid')})" data-postid="{{ post['post_id'] }}" class="post-preview-btn-gr onclick-blue">•••</div>
                    <div class="post-preview-content-caption">
                        <span class="post-preview-content-caption-username">{{ post['username'] }}</span>
                        <div class="post-preview-caption-dot"><i class="loader_dot">•</i></div>
                    </div>
                </div>
            {% elif post['post_type'] == "video" %}
                <div class="post-preview-items-media-container">
                    <video class="post-preview-items-media" muted autoplay loop preload="metadata" onloadstart="this.muted = false" onloadeddata="videoActions(this, document.querySelectorAll('.post-preview-video-actions'), 'hide', 2000)" data-post-id="{{ post['post_id'] }}" poster='assets/imgthumb.gif' src="http://{{ _ipaddr }}:8000/video?uuid={{ post['uid'] }}&ppic={{ post['post_ul'] }}&ptp=post"></video>
                    <!--EDIT: ADD JAVASCRIPT EVENTS -->
                    <div class="player-actions post-preview-video-actions">
                        <div class="media-button fa fa-play" hidden id="play"></div>
                        <div class="media-button fa fa-pause" id="pause"></div>
                    </div>
                    <div class="player-progress post-preview-video-actions">
                        <input class="progress" id="progress" type="range" min="0" value="0" step=".1">
                    </div>
                    <div class="player-actions-bottom post-preview-video-actions">
                        <div class="player-volume-button" onclick="document.querySelector('.post-preview-items-media').muted = true"><i class="fa fa-volume-mute"></i></div>
                        <div class="player-fullscreen-button"><i class="fa fa-expand"></i></div>
                        <div class="player-time-progress-left">00:01</div>
                        <div class="player-time-progress-right">02:34</div>
                    </div>
                    <!-- ... -->

                    <!-- EDIT: ADD AUTO TAGS 
                    <div class="post-preview-tags">
                        <div class="post-preview-tags-left"><i>#digital_hub</i></div>
                        <div class="post-preview-test-left-vertical">•</div>
                        <div class="post-preview-tags-left"><i>asher42</i></div>
                        <div class="post-preview-test-left-vertical">•</div>
                        <div class="post-preview-tags-left"><i>#botstown</i></div>
                        <div class="post-preview-test-left-vertical">•</div>
                        <div class="post-preview-tags-left"><i>webtick</i></div>
                        <div class="post-preview-test-left-vertical">•</div>
                    </div>
                    ... -->

                    <div class="post-preview-btn-gr onclick-blue post-preview-video-actions">•••</div>
                    <div class="post-preview-content-caption"></div>
                </div>
            {% else %}
                <div class="post-preview-items-media-container">
                    <img class="post-preview-items-media" src="assets/notavailablebig.jpg">
                </div>
            {% endif %}
        </div>
        
        <div class="post-preview-items-detail">
            {% if post['profile'] == 'df' %}
            <img class="post-preview-user-media-bottom" src='assets/default.jpg'>
        {% else %}
            <img class="post-preview-user-media-bottom" src="http://{{ _ipaddr }}:8000/image?uuid={{ post['uid'] }}&ppic={{ post['profile'] }}&ptp=profile">
        {% endif %}
            <div onclick="iurl('vprofile', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ post['uid'] }}" class="post-preview-items-username">{{ username | replace(" ", " ")}}{% if post['ctype'] != 'ucf' %} <i class="fa fa-check-circle"></i>{% endif %}</div>
            <div class="post-preview-right-ics">
                <div class="follow-button-right">Save</div>
                <div class="icn post-preview-right-ge onclick-blue"><i class="fa fa-media"></i></div>
            </div>
        </div>
        <div class="post-preview-p-text-bottom">{{ post_text }}</div>
        <div class="mb-20"></div>
        <div class="ics-home-inline mb-6"> 
            <div class="ai-search-cnt">
              <div class="ai-search-icr active"></div>
              <span>Similar</span>
            </div>
            <div class="ai-search-cnt">
              <div class="ai-search-icr"></div>
              <span>Comments {{ helpers._random_str(2, "digits") }}</span>
            </div>
         </div>
        <div class="related-content suggestions mt-8">
            <div class="cc2nt" id="c140">
                <div class="c230"><i class="loader_dot">•</i><i class="loader_dot">•</i><i class="loader_dot">•</i></div>
              </div>
        </div>
        <div class="bottom-pst-ics default-background">
            <img class="bottom-item-image" src="http://{{ _ipaddr }}:8000/image?uuid={{ logged_user_id }}&ppic={{ profile }}&ptp=profile">
            <input type="text" placeholder="Add a comment" onsubmit="iurl('vpost', {pid: this.getAttribute('data-pid') })" data-pid="{{ post['post_id'] }}" class="comment-input">
            <div class="ics-bottom-items">
                <div class="items-ge-cover" onclick="addlike(this, this.getAttribute('data-pid'))" data-pid="{{ post['post_id'] }}"><i class="like-icon far fa-thumbs-o-up"></i> <span class="likes-count">{{ likes|length }}</span> &triangledown;</div>
                <div class="ics-bottom-item-ge"><i class="comments-icon fa fa-comments-o"></i> {{ comments|length }}</div>
                <div class="ics-bottom-item-ge" onclick="sharePost(this, this.getAttribute('data-pid'))" data-pid="{{ post['post_id'] }}"><i class="share-icon fa fa-share"></i> {{ forwards|length }}</div>
            </div>
        </div>
    </div>
</div>
{% endfor %}
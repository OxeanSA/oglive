{% for post in post %}
{% set profile = conn.execute("SELECT profile FROM users WHERE id=='{}'".format(id)).fetchone()['profile'] %}
{% set post_text = post['post_txt'] | replace(_tags("(#\w+)", post['post_txt']), "<font color='#89cff0' class='tagged-user'>{}</font>".format( _tags("(#\w+)", post['post_txt'])) | safe) %}
{% set post_text = post_text | replace(_tags("(@\w+)", post_text), "<font color='#89cff0' class='tagged-user'>{}</font>".format( _tags("@(\w+)", post_text)) | safe) %}
{% set likes = conn.execute("SELECT * FROM likes LEFT JOIN users ON users.id=likes.uid WHERE post_id=='{}'".format(post['post_id'])).fetchall() %}
{% set comments = conn.execute("SELECT * FROM comments LEFT JOIN users ON users.id=comments.uid WHERE post_id=='{}'".format(post['post_id'])).fetchall() %}
{% set forwards = conn.execute("SELECT * FROM forwards LEFT JOIN users ON users.id=forwards.uid WHERE post_id=='{}'".format(post['post_id'])).fetchall() %}
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
                <div class="post-preview-items-img-container">
                    <img class="post-preview-items-img" src="http://{{ _ipaddr }}:8000/image?uuid={{ post['uid'] }}&ppic={{ post['post_pic'] }}&ptp=post">
                    <div class="post-preview-tags">
                        <div class="post-preview-tags-left"><i>#digital_hub</i></div>
                        <div class="test-left-vertical"><svg style="width: 1em; height: 1em;vertical-align: middle;fill: currentColor;overflow: hidden;" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"><path d="M531.185456 943.532317c0 8.899694-6.493901 16.114003-14.503319 16.114003l-9.364275 0c-8.010441 0-14.504342-7.214309-14.504342-16.114003L492.81352 80.46666c0-8.898671 6.493901-16.114003 14.504342-16.114003l9.364275 0c8.009418 0 14.503319 7.215332 14.503319 16.114003L531.185456 943.532317z"  /></svg></div>
                        <div class="post-preview-tags-left"><i>asher42</i></div>
                        <div class="test-left-vertical"><svg style="width: 1em; height: 1em;vertical-align: middle;fill: currentColor;overflow: hidden;" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"><path d="M531.185456 943.532317c0 8.899694-6.493901 16.114003-14.503319 16.114003l-9.364275 0c-8.010441 0-14.504342-7.214309-14.504342-16.114003L492.81352 80.46666c0-8.898671 6.493901-16.114003 14.504342-16.114003l9.364275 0c8.009418 0 14.503319 7.215332 14.503319 16.114003L531.185456 943.532317z"  /></svg></div>
                        <div class="post-preview-tags-left"><i>#botstown</i></div>
                        <div class="test-left-vertical"><svg style="width: 1em; height: 1em;vertical-align: middle;fill: currentColor;overflow: hidden;" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"><path d="M531.185456 943.532317c0 8.899694-6.493901 16.114003-14.503319 16.114003l-9.364275 0c-8.010441 0-14.504342-7.214309-14.504342-16.114003L492.81352 80.46666c0-8.898671 6.493901-16.114003 14.504342-16.114003l9.364275 0c8.009418 0 14.503319 7.215332 14.503319 16.114003L531.185456 943.532317z"  /></svg></div>
                        <div class="post-preview-tags-left"><i>webtick</i></div>
                        <div class="test-left-vertical"><svg style="width: 1em; height: 1em;vertical-align: middle;fill: currentColor;overflow: hidden;" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"><path d="M531.185456 943.532317c0 8.899694-6.493901 16.114003-14.503319 16.114003l-9.364275 0c-8.010441 0-14.504342-7.214309-14.504342-16.114003L492.81352 80.46666c0-8.898671 6.493901-16.114003 14.504342-16.114003l9.364275 0c8.009418 0 14.503319 7.215332 14.503319 16.114003L531.185456 943.532317z"  /></svg></div>
                    </div>
                    <div class="post-preview-btn-gr onclick-blue">•••</div>
                </div>
            {% elif post['post_type'] == "video" %}
                <video class="post-preview-items-video" src="http://{{ _ipaddr }}:8000/video?uuid={{ post['uid'] }}&filename={{ post['post_vid'] }}&type=post"></video>
            {% else %}
                <div class="post-preview-items-img-container">
                    <img class="post-preview-items-img" src="assets/notavailablebig.jpg">
                </div>
            {% endif %}
        </div>
        {% if post['profile'] == 'df' %}
            <img class="post-preview-user-img-bottom" src='assets/default.jpg'>
        {% else %}
            <img class="post-preview-user-img-bottom" src="http://{{ _ipaddr }}:8000/image?uuid={{ post['uid'] }}&ppic={{ post['profile'] }}&ptp=profile">
        {% endif %}
        <div class="post-preview-items-detail mt-14">
            <div class="username">{{ username | replace(" ", " ")}}{% if post['ctype'] != 'ucf' %} <i class="fa fa-check-circle"></i>{% endif %}</div>
            <div class="follow-button-right">following</div>
        </div>
        <div class="post-preview-p-text-bottom">{{ post_text }}</div>
        <div class="mb-20"></div>
        <div class="z-index-lower">
            <div class="comments-user-comment">
                <div class="comment-count">6 comments</div>
                <div class="user-banner">
                    <div class="user">
                        <div class="avatar">
                            <img src="assets/default.jpg">
                            <span class="stat grey"></span>
                        </div>
                        <div class="comment-content-username">Floyd Miles</div>
                    </div>
                </div>
                <div class="content">
                    <div class="comment-content-text">I try out the links on the post, above, none of them...</div>
                </div>
            </div>
        </div>
        <div class="mb-40"></div>
        </div>
        <div class="clear section-title">Related</div>
        <dic class="related-content suggestions mt-8">
        </dic>
        <div class="bottom-pst-ics default-background">
            <img class="bottom-item-image" src="http://{{ _ipaddr }}:8000/image?uuid={{ id }}&ppic={{ profile }}&ptp=profile">
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
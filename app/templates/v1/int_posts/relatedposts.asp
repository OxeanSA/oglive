<div class="post-preview-related-content">
  <div class="column">

  {% for post in data[0] %}
    <div class="column-content-container">
      {% if post['post_type'] == 'image' %}
        <img onload="onImgLoad(this, this.getAttribute('data-src'))" onclick="iurl('postview', {pid: this.getAttribute('data-post-id') })" data-post-id="{{ post['post_id'] }}" class="column-image" src='assets/imgthumb.gif' data-src="http://{{ _ipaddr }}:8000/image?uuid={{ post['uid'] }}&ppic={{ post['post_ul'] }}&ptp=post">
      {% else %}
        <video class="column-image" muted autoplay loop poster='assets/imgthumb.gif' preload="metadata" onclick="iurl('viewpost', {pid: this.getAttribute('data-post-id') })" data-post-id="{{ post['post_id'] }}" src="http://{{ _ipaddr }}:8000/video?uuid={{ post['uid'] }}&ppic={{ post['post_ul'] }}&ptp=post"></video>
        <div class="content-mute-button fa fa-volume-mute" onclick="toggleMute(this, false)"></div>
      {% endif %}
      <div class="content-caption">
        <img class="content-caption-image" src='assets/default.jpg'>
        <span class="content-caption-username">{{ post['username'] }}</span>
        <div class="content-caption-likes">
          <i class="content-caption-likes-icon far fa-thumbs-o-up"></i>
          <span class="content-caption-likes-count">1k</span>
        </div>
      </div>
    </div>
    <!--
    <div class="content-caption">
      {% if post['profile'] == 'df' %}
         <img class="content-caption-image" src='assets/default.jpg'>
      {% else %}
         <img onload="onImgLoad(this, this.getAttribute('data-src'))" src='assets/imgthumb.gif' class="content-caption-image"  data-src="http://{{ _ipaddr }}:8000/image?uuid={{ post['uid'] }}&ppic={{ post['profile'] }}&ptp=profile">
      {% endif %} <span>{{ post['username'] }}</span>
    </div>
    -->
  {% endfor %}
</div>
<div class="column">
  {% for apost in data[1] %}
  <div class="column-content-container">
    {% if apost['post_type'] == 'image' %}
      <img onload="onImgLoad(this, this.getAttribute('data-src'))" onclick="iurl('postview', {pid: this.getAttribute('data-post-id') })" data-post-id="{{ apost['post_id'] }}" class="column-image" src='assets/imgthumb.gif' data-src="http://{{ _ipaddr }}:8000/image?uuid={{ apost['uid'] }}&ppic={{ apost['post_ul'] }}&ptp=post">
    {% else %}
      <video class="column-image" muted autoplay loop poster='assets/imgthumb.gif' preload="metadata" onclick="iurl('viewpost', {pid: this.getAttribute('data-post-id') })" data-post-id="{{ apost['post_id'] }}" src="http://{{ _ipaddr }}:8000/video?uuid={{ apost['uid'] }}&ppic={{ apost['post_ul'] }}&ptp=post"></video>
      <div class="content-mute-button fa fa-volume-mute" onclick="toggleMute(this, false)"></div>
    {% endif %}
    <div class="content-caption">
      <img class="content-caption-image" src='assets/default.jpg'>
      <span class="content-caption-username">{{ apost['username'] }}</span>
      <div class="content-caption-likes">
        <i class="content-caption-likes-icon far fa-thumbs-o-up"></i>
        <span class="content-caption-likes-count">1k</span>
      </div>
    </div>
  </div>
    <!--
    <div class="content-caption"> 
      {% if apost['profile'] == 'df' %}
         <img class="content-caption-image" src='assets/default.jpg'>
      {% else %}
         <img onload="onImgLoad(this, this.getAttribute('data-src'))" src='assets/imgthumb.gif' class="content-caption-image"  data-src="http://{{ _ipaddr }}:8000/image?uuid={{ apost['uid'] }}&ppic={{ apost['profile'] }}&ptp=profile">
      {% endif %} <span>{{ apost['username'] }}</span>
    </div>
    -->
  {% endfor %}
</div>

</div>

<!-- NB: Create columns with javascript
<div class="post-preview-related-content">
    <div class="column">
      <img onload="onImgLoad(this, this.getAttribute('data-src'))" class="column-image" src='assets/imgthumb.gif' data-src="assets/df5.jpg">
      <div class="content-caption"><img onload="onImgLoad(this, this.getAttribute('data-src'))" class="content-caption-image" src='assets/imgthumb.gif' data-src="assets/df5.jpg"> <span>Text below</span></div>
      <img onload="onImgLoad(this, this.getAttribute('data-src'))" class="column-image" src='assets/imgthumb.gif' data-src="assets/df3.jpg">
      <div class="content-caption"><img onload="onImgLoad(this, this.getAttribute('data-src'))" class="content-caption-image" src='assets/imgthumb.gif' data-src="assets/df5.jpg"> <span>Text below</span></div>
      <img onload="onImgLoad(this, this.getAttribute('data-src'))" class="column-image" src='assets/imgthumb.gif' data-src="assets/df2.jpg">
      <div class="content-caption"><img onload="onImgLoad(this, this.getAttribute('data-src'))" class="content-caption-image" src='assets/imgthumb.gif' data-src="assets/df5.jpg"> <span>Text below</span></div>
      <img onload="onImgLoad(this, this.getAttribute('data-src'))" class="column-image" src='assets/imgthumb.gif' data-src="assets/df5.jpg">
      <div class="content-caption"><img onload="onImgLoad(this, this.getAttribute('data-src'))" class="content-caption-image" src='assets/imgthumb.gif' data-src="assets/df5.jpg"> <span>Text below</span></div>
      <img onload="onImgLoad(this, this.getAttribute('data-src'))" class="column-image" src='assets/imgthumb.gif' data-src="assets/df2.jpg">
      <div class="content-caption"><img onload="onImgLoad(this, this.getAttribute('data-src'))" class="content-caption-image" src='assets/imgthumb.gif' data-src="assets/df5.jpg"> <span>Text below</span></div>
      <img onload="onImgLoad(this, this.getAttribute('data-src'))" class="column-image" src='assets/imgthumb.gif' data-src="assets/df.jpg">
      <div class="content-caption"><img onload="onImgLoad(this, this.getAttribute('data-src'))" class="content-caption-image" src='assets/imgthumb.gif' data-src="assets/df5.jpg"> <span>Text below</span></div>
      <img onload="onImgLoad(this, this.getAttribute('data-src'))" class="column-image" src='assets/imgthumb.gif' data-src="assets/df4.jpg">
      <div class="content-caption"><img onload="onImgLoad(this, this.getAttribute('data-src'))" class="content-caption-image" src='assets/imgthumb.gif' data-src="assets/df5.jpg"> <span>Text below</span></div>
    </div>
    <div class="column">
      <img onload="onImgLoad(this, this.getAttribute('data-src'))" class="column-image" src='assets/imgthumb.gif' data-src="assets/df2.jpg">
      <div class="content-caption"><img onload="onImgLoad(this, this.getAttribute('data-src'))" class="content-caption-image" src='assets/imgthumb.gif' data-src="assets/df5.jpg"> <span>Text below</span></div>
      <img onload="onImgLoad(this, this.getAttribute('data-src'))" class="column-image" src='assets/imgthumb.gif' data-src="assets/df5.jpg">
      <div class="content-caption"><img onload="onImgLoad(this, this.getAttribute('data-src'))" class="content-caption-image" src='assets/imgthumb.gif' data-src="assets/df5.jpg"> <span>Text below</span></div>
      <img onload="onImgLoad(this, this.getAttribute('data-src'))" class="column-image" src='assets/imgthumb.gif' data-src="assets/df2.jpg">
      <div class="content-caption"><img onload="onImgLoad(this, this.getAttribute('data-src'))" class="content-caption-image" src='assets/imgthumb.gif' data-src="assets/df5.jpg"> <span>Text below</span></div>
      <img onload="onImgLoad(this, this.getAttribute('data-src'))" class="column-image" src='assets/imgthumb.gif' data-src="assets/df3.jpg">
      <div class="content-caption"><img onload="onImgLoad(this, this.getAttribute('data-src'))" class="content-caption-image" src='assets/imgthumb.gif' data-src="assets/df5.jpg"> <span>Text below</span></div>
      <img onload="onImgLoad(this, this.getAttribute('data-src'))" class="column-image" src='assets/imgthumb.gif' data-src="assets/df.jpg">
      <div class="content-caption"><img onload="onImgLoad(this, this.getAttribute('data-src'))" class="content-caption-image" src='assets/imgthumb.gif' data-src="assets/df5.jpg"> <span>Text below</span></div>
      <img onload="onImgLoad(this, this.getAttribute('data-src'))" class="column-image" src='assets/imgthumb.gif' data-src="assets/df4.jpg">
      <div class="content-caption"><img onload="onImgLoad(this, this.getAttribute('data-src'))" class="content-caption-image" src='assets/imgthumb.gif' data-src="assets/df5.jpg"> <span>Text below</span></div>
    </div>
</div>
-->
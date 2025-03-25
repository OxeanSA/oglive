{% for stry in stories %}
  <div class='stry-cnt-inl'>
    <div class='stry-container'>
      <div class="gradient-bg">
        <div class="u-pic-cnt">
          {% if stry['story_pic'] == None %}
            <img class="story-u-pic" src="assets/default.jpg">
          {% else %}
            <img class="story-u-pic" onclick="iurl('vstory', {suid: this.getAttribute('data-sid') })" data-sid="{{ stry['uid'] }}" src="http://{{ _ipaddr }}:8000/image?uuid={{ stry['uid'] }}&ppic={{ stry['story_pic'] }}&ptp=story">
          {% endif %}
        </div>
      </div>
      <!-- | replace(stry["username"], _tags("@(\w+)", stry["username"]) | safe) -->
      <div class="stry-uname">{{ _trim(stry["username"], 7) | replace("_", ".") | replace("@", "") }}</div>
    </div>
  </div>
{% endfor %}
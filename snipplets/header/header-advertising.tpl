{% set has_advertising_bar = false %}
{% set num_messages = 0 %}
{% for adbar in ['ad_bar_01', 'ad_bar_02', 'ad_bar_03'] %}
    {% set advertising_text = attribute(settings,"#{adbar}_text") %}
    {% if advertising_text %}
        {% set num_messages = num_messages + 1 %}
    {% endif %}
{% endfor %}
{% set show_adbar_only_mobile = 'adbar_img_mobile.jpg' | has_custom_image and (not 'adbar_img_desktop.jpg' | has_custom_image and not num_messages) %}
{% set show_adbar_only_desktop = 'adbar_img_desktop.jpg' | has_custom_image and (not 'adbar_img_mobile.jpg' | has_custom_image and not num_messages) %}
{% set adbar_images = 'adbar_img_mobile.jpg' | has_custom_image or 'adbar_img_desktop.jpg' | has_custom_image %}
{% set both_images_without_messages = 'adbar_img_mobile.jpg' | has_custom_image and 'adbar_img_desktop.jpg' | has_custom_image and not num_messages %}
{% set adbar_animated = settings.ad_bar_animate %}
{% set adbar_inside_head_classes = settings.head_transparent ? 'section-adbar-head' %}
{% set adbar_with_image_classes = adbar_images ? 'section-adbar-with-image' %}
{% set adbar_animated_classes = adbar_animated ? 'section-adbar-animated' %}
{% set adbar_colors_classes = settings.adbar_colors ? 'section-adbar-colors' %}
{% set adbar_messages_classes = num_messages ? 'adbar-with-messages' %}
{% set adbar_visibility_classes = show_adbar_only_mobile ? 'd-md-none' : show_adbar_only_desktop ? 'd-none d-md-block' %}
{% set adbar_animated_container_classes = adbar_animated ? 'js-adbar-animated adbar-animated' : 'js-swiper-adbar swiper-container text-center container' %}
{% set adbar_animated_text_container_classes = adbar_animated ? 'js-adbar-text-container' : 'swiper-wrapper' %}
{% set adbar_animated_text_classes = adbar_animated ? 'mr-4' : 'swiper-slide slide-container' %}
{% set adbar_no_text_classes = not num_messages ? 'p-0' %}

{% if settings.ad_bar and (num_messages or adbar_images ) %}
    <section class="js-adbar section-adbar transition-soft {{ adbar_inside_head_classes }} {{ adbar_animated_classes }} {{ adbar_colors_classes }} {{ adbar_messages_classes }} {{ adbar_visibility_classes }} {{ adbar_no_text_classes }} {{ adbar_with_image_classes }}">
        {% if num_messages %}
            <div class="{{ adbar_animated_container_classes }}">
                <div class="{{ adbar_animated_text_container_classes }} adbar-text-container align-items-center">

                    {% if adbar_animated %}
                        {% if num_messages == 1 %}
                            {% set repeat_number = 16 %}
                        {% else %}
                            {% set repeat_number = num_messages == 2 ? '8' : '5' %}
                        {% endif %}
                    {% else %}
                        {% set repeat_number = 1 %}
                    {% endif %}
                    {% for i in 1..repeat_number %}
  {% for adbar in ['ad_bar_01', 'ad_bar_02', 'ad_bar_03'] %}
    {% set advertising_text = attribute(settings, adbar ~ "_text") %}
    {% set advertising_url = attribute(settings, adbar ~ "_url") %}
    {% if advertising_text %}
      <span class="adbar-message {{ adbar_animated_text_classes }} {% if num_messages > 1 and not adbar_animated %}px-4{% endif %}">
        {% if adbar == 'ad_bar_01' %}
          <div class="d-flex align-items-center justify-content-between w-100 gap-2">
            {% if advertising_url %}
              <a href="{{ advertising_url }}" class="flex-grow-1 text-truncate me-2 {% if not adbar_animated %}d-block{% endif %}">
                {{ advertising_text }}
              </a>
            {% else %}
              <span class="flex-grow-1 text-truncate me-2">{{ advertising_text }}</span>
            {% endif %}

            <button id="copy-button-ad_bar_01" class="btn btn-sm btn-outline-secondary" type="button">
                <div>
                    <span class="copy-label"> COPIAR</span>
                    <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="14px" fill="#000000">
                        <path d="M735.38-240H344.62q-27.62 0-46.12-18.5Q280-277 280-304.62v-510.76q0-27.62 18.5-46.12Q317-880 344.62-880H620l180 180v395.38q0 27.62-18.5 46.12Q763-240 735.38-240ZM600-680v-160H344.62q-9.24 0-16.93 7.69-7.69 7.69-7.69 16.93v510.76q0 9.24 7.69 16.93 7.69 7.69 16.93 7.69h390.76q9.24 0 16.93-7.69 7.69-7.69 7.69-16.93V-680H600ZM184.62-80Q157-80 138.5-98.5 120-117 120-144.62V-640h40v495.38q0 9.24 7.69 16.93 7.69 7.69 16.93 7.69H560v40H184.62ZM320-840v160-160 560-560Z"></path>
                    </svg>
                </div>
            </button>
          </div>
        {% else %}
          {% if advertising_url %}
            <a href="{{ advertising_url }}" {% if not adbar_animated %}class="d-block w-100"{% endif %}>
              {{ advertising_text }}
            </a>
          {% else %}
            {{ advertising_text }}
          {% endif %}
        {% endif %}
      </span>
    {% endif %}
  {% endfor %}
{% endfor %}

                </div>
                {% if num_messages > 1 and not adbar_animated %}
                    <div class="js-swiper-adbar-prev swiper-button-absolute swiper-button-prev svg-icon-text">
                        <svg class="icon-inline icon-sm icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
                    </div>
                    <div class="js-swiper-adbar-next swiper-button-absolute swiper-button-next svg-icon-text ml-2">
                        <svg class="icon-inline icon-sm"><use xlink:href="#chevron"/></svg>
                    </div>
                {% endif %}
            </div>
        {% endif %}
        {% if num_messages and adbar_images %}
            <div class="adbar-img-container {% if num_messages %}adbar-with-messages{% endif %}">
        {% endif %}
        {% if 'adbar_img_mobile.jpg' | has_custom_image %}
            {% if settings.adbar_img_mobile_url and not num_messages %}
                <a href="{{ settings.adbar_img_mobile_url }}" class="w-100 d-block d-md-none">
            {% endif %}
                    <img data-src="" data-srcset='{{ 'adbar_img_mobile.jpg' | static_url | settings_image_url('large') }} 480w, {{ 'adbar_img_mobile.jpg' | static_url | settings_image_url('huge') }} 640w, {{ 'adbar_img_mobile.jpg' | static_url | settings_image_url('original') }} 1024w' class='js-adbar-img-mobile lazyload adbar-img d-block d-md-none mb-neg-1'/>
            {% if settings.adbar_img_mobile_url and not num_messages %}
                </a>
            {% endif %}
        {% endif %}

        {% if 'adbar_img_desktop.jpg' | has_custom_image %}
            {% if settings.adbar_img_desktop_url and not num_messages %}
                <a href="{{ settings.adbar_img_desktop_url }}" class="w-100 d-none d-md-block">
            {% endif %}
                    <img data-src="" data-srcset='{{ 'adbar_img_desktop.jpg' | static_url | settings_image_url('large') }} 480w, {{ 'adbar_img_desktop.jpg' | static_url | settings_image_url('huge') }} 640w, {{ 'adbar_img_desktop.jpg' | static_url | settings_image_url('original') }} 1024w, {{ 'adbar_img_desktop.jpg' | static_url | settings_image_url('1080p') }} 1920w' class='js-adbar-img-desktop lazyload adbar-img d-none d-md-block mb-neg-1'/>
            {% if settings.adbar_img_desktop_url and not num_messages %}
                </a>
            {% endif %}
        {% endif %}
        {% if num_messages and adbar_images %}
            </div>
        {% endif %}
    </section>
{% endif %}

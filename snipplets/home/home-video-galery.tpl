{% set video_gallery_pairs = [] %}
{% set video_gallery_slider_items = [] %}
{% set video_gallery_sources = [
    {
        'image_name': 'home_video_gallery_image_1.jpg',
        'video_id': settings.home_video_gallery_vimeo_id_1,
        'photo_link': settings.home_video_gallery_photo_link_1,
        'video_link': settings.home_video_gallery_video_link_1
    },
    {
        'image_name': 'home_video_gallery_image_2.jpg',
        'video_id': settings.home_video_gallery_vimeo_id_2,
        'photo_link': settings.home_video_gallery_photo_link_2,
        'video_link': settings.home_video_gallery_video_link_2
    },
] %}

{% for gallery_source in video_gallery_sources %}
    {% set has_image = gallery_source.image_name | has_custom_image %}
    {% set has_video = gallery_source.video_id %}
    {% if has_image and has_video %}
        {% set video_gallery_pairs = video_gallery_pairs | merge([gallery_source | merge({'pair_index': loop.index}) ]) %}
        {% set video_gallery_slider_items = video_gallery_slider_items | merge([
            { 'type': 'image', 'image_name': gallery_source.image_name, 'pair_index': loop.index, 'link': gallery_source.photo_link },
            { 'type': 'video', 'video_id': gallery_source.video_id, 'pair_index': loop.index, 'link': gallery_source.video_link }
        ]) %}
    {% endif %}
{% endfor %}

{% if video_gallery_pairs %}
<section class="section-home section-video-gallery position-relative" data-store="home-video-gallery" data-transition="fade-in-up">
    <div class="px-0 px-md-3">
        <div class="home-video-gallery-grid d-none d-md-block">
            <div class="row row-grid">
                {% for pair in video_gallery_pairs %}
                    <div class="col-12 col-md-3 col-grid mb-3 mb-md-0">
                        {% if pair.photo_link %}
                            <a href="{{ pair.photo_link | setting_url }}" class="home-video-gallery-media home-video-gallery-photo">
                        {% else %}
                            <div class="home-video-gallery-media home-video-gallery-photo">
                        {% endif %}
                            <img
                                src="{{ 'images/empty-placeholder.png' | static_url }}"
                                data-sizes="auto"
                                data-expand="-10"
                                data-srcset="{{ pair.image_name | static_url | settings_image_url('large') }} 480w, {{ pair.image_name | static_url | settings_image_url('huge') }} 640w, {{ pair.image_name | static_url | settings_image_url('original') }} 1024w, {{ pair.image_name | static_url | settings_image_url('1080p') }} 1920w"
                                class="lazyautosizes lazyload fade-in w-100 h-100"
                                alt="Galeria de vídeos {{ pair.pair_index }} - imagem" />
                            <div class="placeholder-fade placeholder-banner"></div>
                        {% if pair.photo_link %}
                            </a>
                        {% else %}
                            </div>
                        {% endif %}
                    </div>
                    <div class="col-12 col-md-3 col-grid mb-3 mb-md-0">
                        {% if pair.video_link %}
                            <a href="{{ pair.video_link | setting_url }}" class="home-video-gallery-media home-video-gallery-video">
                        {% else %}
                            <div class="home-video-gallery-media home-video-gallery-video">
                        {% endif %}
                            <iframe
                                src="https://player.vimeo.com/video/{{ pair.video_id }}?background=1&autoplay=1&muted=1&loop=1&autopause=0&playsinline=1"
                                class="home-video-gallery-iframe"
                                loading="lazy"
                                title="Vídeo {{ pair.pair_index }} da galeria"
                                frameborder="0"
                                allow="autoplay; fullscreen; picture-in-picture"
                                allowfullscreen></iframe>
                        {% if pair.video_link %}
                            </a>
                        {% else %}
                            </div>
                        {% endif %}
                    </div>
                {% endfor %}
            </div>
        </div>

        {% if video_gallery_slider_items %}
            <div class="home-video-gallery-slider d-md-none">
                <div class="js-swiper-home-video-gallery swiper-container">
                    <div class="swiper-wrapper">
                        {% for slide in video_gallery_slider_items %}
                            <div class="swiper-slide home-video-gallery-slide">
                                {% set slide_classes = slide.type == 'image' ? 'home-video-gallery-photo' : 'home-video-gallery-video' %}
                                {% if slide.link %}
                                    <a href="{{ slide.link | setting_url }}" class="home-video-gallery-media {{ slide_classes }}">
                                {% else %}
                                    <div class="home-video-gallery-media {{ slide_classes }}">
                                {% endif %}
                                    {% if slide.type == 'image' %}
                                        <img
                                            src="{{ 'images/empty-placeholder.png' | static_url }}"
                                            data-sizes="auto"
                                            data-expand="-10"
                                            data-srcset="{{ slide.image_name | static_url | settings_image_url('large') }} 480w, {{ slide.image_name | static_url | settings_image_url('huge') }} 640w, {{ slide.image_name | static_url | settings_image_url('original') }} 1024w, {{ slide.image_name | static_url | settings_image_url('1080p') }} 1920w"
                                            class="lazyautosizes lazyload fade-in w-100 h-100"
                                            alt="Galeria de vídeos {{ slide.pair_index }} - imagem" />
                                        <div class="placeholder-fade placeholder-banner"></div>
                                    {% else %}
                                        <iframe
                                            class="home-video-gallery-iframe js-home-video-gallery-iframe-mobile"
                                            data-mobile-src="https://player.vimeo.com/video/{{ slide.video_id }}?background=1&autoplay=1&muted=1&loop=1&autopause=0&playsinline=1"
                                            loading="lazy"
                                            title="Vídeo {{ slide.pair_index }} da galeria"
                                            frameborder="0"
                                            allow="autoplay; fullscreen; picture-in-picture"
                                            allowfullscreen></iframe>
                                    {% endif %}
                                {% if slide.link %}
                                    </a>
                                {% else %}
                                    </div>
                                {% endif %}
                            </div>
                        {% endfor %}
                    </div>
                </div>
            </div>
        {% endif %}
    </div>
</section>
{% endif %}

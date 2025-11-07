{% set image_sizes = ['small', 'large', 'huge', 'original', '1080p'] %}
{% set category_images = [] %}
{% set has_category_images = category.images is not empty %}

{% for size in image_sizes %}
    {% if has_category_images %}
        {# Define images for admin categories #}
        {% set category_images = category_images|merge({(size):(category.images | first | category_image_url(size))}) %}
    {% else %}
        {# Define images for general banner #}
        {% set category_images = category_images|merge({(size):('banner-products.jpg' | static_url | settings_image_url(size))}) %}
    {% endif %}
{% endfor %}

{% set category_image_url = 'banner-products.jpg' | static_url %}

<section class="category-banner position-relative mb-3" data-store="category-banner">
    <img class="category-banner-image d-none d-md-block lazyautosizes lazyload fade-in w-100" src="{{ category_images['small'] }}" data-srcset="{{ category_images['large'] }} 480w, {{ category_images['huge'] }} 640w, {{ category_images['original'] }} 1024w, {{ category_images['1080p'] }} 1920w" data-sizes="auto" alt="{{ 'Banner de la categoría' | translate }} {{ category.name }}" />
    {% if category.id == '34976775' %}
        <img class="category-banner-image d-block d-md-none lazyautosizes lazyload fade-in w-100" src="https://d1a9qnv764bsoo.cloudfront.net/stores/006/038/253/rte/Capelli Rossi - Google Display Ads_ - black friday.png" data-sizes="auto" alt="{{ 'Banner de la categoría' | translate }} {{ category.name }}" />
    {% endif %}
</section>
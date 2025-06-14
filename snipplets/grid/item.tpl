{# /*============================================================================
  #Item grid
==============================================================================*/

#Properties

#Slide Item

#}

{% set slide_item = slide_item | default(false) %}

{% if template == 'home'%}
    {% set columns_desktop = section_columns_desktop %}
    {% set columns_mobile = section_columns_mobile %}
    {% set section_slider = section_slider %}
{% else %}
    {% set columns_desktop = settings.grid_columns_desktop %}
    {% set columns_mobile = settings.grid_columns_mobile %}
    {% if template == 'product'%}
        {% set section_slider = true %}
    {% endif %}
{% endif %}

{% set mobile_column_class = columns_mobile == 1 ? '12' : '6' %}
{% set desktop_column_class = 
    columns_desktop == 2 ? '6' :
    columns_desktop == 3 ? '4' :
    columns_desktop == 4 ? '3' :
    columns_desktop == 5 ? '2-4' : '2'
 %}

{# Item image slider #}

{% set show_image_slider = 
    (template == 'category' or template == 'search')
    and settings.product_item_slider 
    and not slide_item
    and not reduced_item 
    and not has_filters
    and product.other_images
%}

{% if show_image_slider %}
    {% set slider_controls_container_class = 'item-slider-controls-container svg-icon-text d-none d-md-block' %}
    {% set control_next_svg_id = 'chevron' %}
    {% set control_prev_svg_id = 'chevron' %}
{% endif %}

{# Secondary images #}

{% set show_secondary_image = settings.product_hover %}

    <div class="js-item-product{% if slide_item %} js-item-slide swiper-slide{% endif %} col-{{ mobile_column_class }} col-md-{{ desktop_column_class }} item-product col-grid {% if reduced_item %}item-product-reduced{% endif %}" data-product-type="list" data-product-id="{{ product.id }}" data-store="product-item-{{ product.id }}" data-component="product-list-item" data-component-value="{{ product.id }}">
        <div class="item {% if reduced_item %}mb-0{% endif %}">
            {% if (settings.quick_shop or settings.product_color_variants) and not reduced_item %}
                <div class="js-product-container js-quickshop-container{% if product.variations %} js-quickshop-has-variants{% endif %} position-relative" data-variants="{{ product.variants_object | json_encode }}" data-quickshop-id="quick{{ product.id }}">
            {% endif %}
            {% set product_url_with_selected_variant = has_filters ?  ( product.url | add_param('variant', product.selected_or_first_available_variant.id)) : product.url  %}

            {# Set how much viewport space the images will take to load correct image #}

            {% if params.preview %}
                {% set mobile_image_viewport_space = '100' %}
                {% set desktop_image_viewport_space = '50' %}
            {% else %}
                {% if columns_mobile == 2 %}
                    {% set mobile_image_viewport_space = '50' %}
                {% else %}
                    {% set mobile_image_viewport_space = '100' %}
                {% endif %}

                {% if columns_desktop == 4 %}
                    {% set desktop_image_viewport_space = '25' %}
                {% elseif columns_desktop == 3 %}
                    {% set desktop_image_viewport_space = '33' %}
                {% else %}
                    {% set desktop_image_viewport_space = '50' %}
                {% endif %}
            {% endif %}

            {% set image_classes = 'js-item-image lazyautosizes lazyload img-absolute img-absolute-centered fade-in' %}
            {% set data_expand = show_image_slider ? '50' : '-10' %}

            {% set floating_elements %}
                {% if not reduced_item %}
                    {% include 'snipplets/labels.tpl' with {labels_floating: true} %}
                {% endif %}
            {% endset %}
            
            {{ component(
                'product-item-image', {
                    image_lazy: true,
                    image_lazy_js: true,
                    image_thumbs: ['small', 'medium', 'large', 'huge', 'original'],
                    image_data_expand: data_expand,
                    image_secondary_data_sizes: 'auto',
                    image_sizes: '(max-width: 768px)' ~ mobile_image_viewport_space ~ 'vw, (min-width: 769px)' ~ desktop_image_viewport_space ~ 'vw',
                    secondary_image: show_secondary_image,
                    slider: show_image_slider,
                    placeholder: true,
                    custom_content: floating_elements,
                    slider_pagination_container: true,
                    product_item_image_classes: {
                        image_container: 'item-image' ~ (columns == 1 ? ' item-image-big') ~ (show_image_slider ? ' item-image-slider'),
                        image_padding_container: 'js-item-image-padding position-relative d-block',
                        image: image_classes,
                        image_featured: 'item-image-featured',
                        image_secondary: 'item-image-secondary',
                        slider_container: 'swiper-container position-absolute h-100 w-100',
                        slider_wrapper: 'swiper-wrapper',
                        slider_slide: 'swiper-slide item-image-slide',
                        slider_control_pagination_container: 'item-slider-pagination-container d-md-none ' ~ (product.images_count == 2 ? 'two-bullets'),
                        slider_control_pagination: 'swiper-pagination item-slider-pagination',
                        slider_control: 'icon-inline icon-lg',
                        slider_control_prev_container: 'swiper-button-prev ' ~ slider_controls_container_class,
                        slider_control_prev: 'icon-flip-horizontal',
                        slider_control_next_container: 'swiper-button-next ' ~ slider_controls_container_class,
                        more_images_message: 'item-more-images-message',
                        placeholder: 'placeholder-fade',
                    },
                    control_next_svg_id: control_next_svg_id,
                    control_prev_svg_id: control_prev_svg_id,
                })
            }}

            {% if (settings.quick_shop or settings.product_color_variants) and product.available and product.display_price and product.variations and not reduced_item %}

                {# Hidden product form to update item image and variants: Also this is used for quickshop popup #}

                <div class="js-item-variants hidden">
                    <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                        <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                        {% if product.variations %}
                            {% include "snipplets/product/product-variants.tpl" with {quickshop: true} %}
                        {% endif %}
                        {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                        {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

                        {# Add to cart CTA #}

                        {% set show_product_quantity = product.available and product.display_price %}

                        <div class="row no-gutters mt-3">

                            {% if show_product_quantity %}
                                {% include "snipplets/product/product-quantity.tpl" with {quickshop: true} %}
                            {% endif %}

                            <div class="{% if show_product_quantity %}col-8 col-md-9{% else %}col-12{% endif %}">

                                <input type="submit" class="js-addtocart js-prod-submit-form btn-add-to-cart btn btn-primary btn-big w-100 {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} />

                                {# Fake add to cart CTA visible during add to cart event #}

                                {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "btn-big"} %}
                            </div>
                        </div>
                    </form>
                </div>

            {% endif %}
            {% set show_labels = not product.has_stock or product.compare_at_price or product.promotional_offer %}
            <div class="item-description pt-3" data-store="product-item-info-{{ product.id }}">
                <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" aria-label="{{ product.name }}" class="item-link">
                    {% if settings.product_color_variants and not reduced_item %}
                        {% include 'snipplets/grid/item-colors.tpl' %}
                    {% endif %}
                    <div class="js-item-name item-name mb-2 font-small opacity-80" data-store="product-item-name-{{ product.id }}">{{ product.name }}</div>
                    {% if product.display_price %}
                        <div class="item-price-container {% if settings.quick_shop and not reduced_item %}mb-3{% endif %}" data-store="product-item-price-{{ product.id }}">
                            <div class="d-block mb-1 mr-1">
                                <span class="js-price-display item-price font-weight-bold {% if settings.payment_discount_price %}font-body{% endif %}" data-product-price="{{ product.price }}">
                                    {{ product.price | money }}
                                </span>
                                {% if not reduced_item %}
                                    {% include 'snipplets/labels.tpl' %}
                                {% endif %}
                            </div>
                            {% if not reduced_item %}
                                <span class="js-compare-price-display price-compare" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %}style="display:inline-block;"{% endif %}>
                                    {{ product.compare_at_price | money }}
                                </span>
                            {% endif %}

                             {% set product_can_show_installments = product.show_installments and product.display_price and product.get_max_installments.installment > 1 and settings.product_installments and not reduced_item %}

                            {% set discount_price_spacing_classes = product_can_show_installments ? 'mb-2' %}

                            {{ component('payment-discount-price', {
                                    visibility_condition: settings.payment_discount_price and not reduced_item,
                                    location: 'product',
                                    container_classes: discount_price_spacing_classes ~ " mt-2 font-weight-bold font-smallest",
                                    text_classes: {
                                        price: 'font-small',
                                    },
                                }) 
                            }}
                            {% if product_can_show_installments %}
                                {{ component('installments', {'location' : 'product_item' , 'short_wording' : true, container_classes: { installment: "item-installments mt-2"}}) }}
                            {% endif %}
                        </div>
                    {% endif %}
                    {% if product.available and product.display_price and settings.quick_shop %}
                        {% if settings.quick_shop and not reduced_item %}
                            <div class="item-actions d-inline-block">
                                {% if product.variations %}

                                    {# Open quickshop popup if has variants #}

                                    <span data-toggle="#quickshop-modal" href="#" class="js-quickshop-modal-open {% if slide_item %}js-quickshop-slide{% endif %} js-modal-open btn btn-primary btn-small btn-smallest-md px-4" title="{{ 'Compra rápida de' | translate }} {{ product.name }}" aria-label="{{ 'Compra rápida de' | translate }} {{ product.name }}" data-component="product-list-item.add-to-cart" data-component-value="{{product.id}}">
                                        <span class="js-open-quickshop-wording">{{ 'Comprar' | translate }}</span>
                                    </span>
                                {% else %}
                                    {# If not variants add directly to cart #}
                                    <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                                        <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                                        {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                                        {% set texts = {'cart': "Comprar", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

                                        <div class="js-item-submit-container item-submit-container position-relative float-left d-inline-block w-100">
                                            <input type="submit" class="js-addtocart js-prod-submit-form js-quickshop-icon-add btn btn-primary btn-small btn-smallest-md px-4 {{ state }}" value="{{ texts[state] | translate }}" alt="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-component="product-list-item.add-to-cart" data-component-value="{{ product.id }}"/>
                                        </div>

                                        {# Fake add to cart CTA visible during add to cart event #}

                                        {% include 'snipplets/placeholders/button-placeholder.tpl' with {direct_add: true} %}
                                    </form>
                                {% endif %}
                            </div>
                        {% endif %}
                    {% endif %}
                </a>
            </div>
            {% if (settings.quick_shop or settings.product_color_variants) and not reduced_item %}
                </div>{# This closes the quickshop tag #}
            {% endif %}

            {# Structured data to provide information for Google about the product content #}
            {{ component('structured-data', {'item': true}) }}
        </div>
    </div>

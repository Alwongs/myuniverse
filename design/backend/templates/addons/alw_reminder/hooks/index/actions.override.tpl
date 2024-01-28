{if $smarty.request.dispatch == 'index.index'}

    <div class="btn-bar-left nav__actions-back mobile-hidden">
        {include file="common/last_viewed_items.tpl"}
    </div>

    <div class="btn-bar-left overlay-navbar-open-container mobile-visible">
        <a role="button" class="btn mobile-visible mobile-menu-toggler" data-ca-mobile-menu-is-convert-dropdown="true">
            {include_ext file="common/icon.tpl" class="icon icon-align-justify mobile-visible-inline overlay-navbar-open"}
            <span class="cc-notify-marker-container" data-ca-notifications-mark></span>
        </a>
    </div>

    <div class="title nav__actions-title {if $select_storefront}title--storefronts{/if}">

        <h2 class="title__heading" title="{$title}">{$title}</h2>

        <!--mobile quick search-->
        <div class="mobile-visible pull-right search-mobile-group cm-search-mobile-group"
            data-ca-search-mobile-back="#search_mobile_back"
            data-ca-search-mobile-btn="#search_mobile_btn"
            data-ca-search-mobile-block="#search_mobile_block"
            data-ca-search-mobile-input="#gs_text_mobile"
        >
            <button class="btn search-mobile-btn" id="search_mobile_btn">{include_ext file="common/icon.tpl" class="icon-search search-mobile-icon"}</button>
            <div class="search search-mobile-block cm-search-mobile-search hidden" id="search_mobile_block">
                <button class="search-mobile-back" type="button" id="search_mobile_back">{include_ext file="common/icon.tpl" class="icon-remove"}</button>
                <button class="search_button search-mobile-button" type="submit" id="search_button_mobile" form="global_search">{include_ext file="common/icon.tpl" class="icon-search"}</button>
                <label for="gs_text_mobile" class="search-mobile-label"><input type="text" class="cm-autocomplete-off search-mobile-input" id="gs_text_mobile" name="q" value="{$smarty.request.q}" form="global_search" placeholder="{__("admin_search_field")}" disabled /></label>
            </div>
        </div>
        <!--mobile end quick search-->
    </div>


    {include file="common/tools.tpl" 
        title=__("alw_reminder.add_event") 
        tool_href="events.update&page_url=index.index" 
        prefix="top" 
        icon="icon-plus"
    }
    
{/if}


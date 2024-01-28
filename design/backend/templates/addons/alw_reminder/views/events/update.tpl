{capture name="mainbox"}
    {if $event.event_id}
        {assign var="id" value=$event.event_id}
    {else}
        {assign var="id" value=0}
    {/if}

    <form id="form" action="{""|fn_url}" method="post" name="product_update_form" class="form-horizontal form-edit  cm-disable-empty-files {if $is_form_readonly}cm-hide-inputs{/if}" enctype="multipart/form-data"> {* product update form *}
        <input type="hidden" name="event_id" value="{$id}" />
        <input type="hidden" name="redirect_url" value="{$redirect_url}" />

        {include file="common/subheader.tpl" title=__("information") target="#acc_information"}

        <div id="acc_information" class="collapse in collapse-visible">
            <div class="control-group {$no_hide_input_if_shared_product}">
                <label for="product_description_product" class="control-label cm-required">{__("name")}</label>
                <div class="controls">
                    <div class="input-group">
                        <input class="input-large"
                            form="form"
                            type="text"
                            name="event_data[event]"
                            id="product_description_product"
                            value="{$event.event}"
                        />
                    </div>
                </div>
            </div>

            <div class="control-group {$no_hide_input_if_shared_product}">
                <label for="product_description_product" class="control-label cm-required">{__("description")}</label>
                <div class="controls">
                    <div class="input-group">
                        <input class="input-large"
                            form="form"
                            type="text"
                            name="event_data[description]"
                            id="product_description_product"
                            value="{$event.description}"
                        />
                    </div>
                </div>
            </div>

            <div class="control-group">
                <label for="elm_banner_type" class="control-label cm-required">{__("type")} {$event.type}</label>
                <div class="controls">
                <select name="event_data[type]" id="elm_banner_type">
                    <option {if $event.type == "U"}selected="selected"{/if} value="U">{__("alw_reminder.unique")}</option>        
                    <option {if $event.type == "M"}selected="selected"{/if} value="M">{__("alw_reminder.monthly")}</option>
                    <option {if $event.type == "A"}selected="selected"{/if} value="A">{__("alw_reminder.annual")}</option>
                </select>
                </div>
            </div>

            <div class="control-group {$no_hide_input_if_shared_product}">
                <label class="control-label cm-required">{__("alw_reminder.event_date")}</label>
                <div class="controls">
                    {include file="addons/alw_reminder/views/components/calendar.tpl" date_id="from_date_holder" date_name="event_data[date]" date_val=$event.timestamp}
                </div>
            </div>
        </div>

        {capture name="buttons"}
            {if $id}
                {capture name="tools_list"}
                    {if $view_uri}
                        <li>{btn type="list" target="_blank" text=__("preview") href=$view_uri}</li>
                        <li class="divider"></li>
                    {/if}
                    {if $allow_clone}
                    <li>{btn type="list" text=__("clone") href="products.clone?product_id=`$id`" method="POST"}</li>
                    {/if}
                    {if $allow_save}
                        <li>{btn type="list" text=__("delete") class="cm-confirm" href="products.delete?product_id=`$id`" method="POST"}</li>
                    {/if}
                {/capture}
                {dropdown content=$smarty.capture.tools_list}
            {/if}
            {include file="buttons/save_cancel.tpl" but_meta="cm-product-save-buttons" but_role="submit-link" but_name="dispatch[events.update]" but_target_form="product_update_form" save=$id}
        {/capture}
    </form>
{/capture}

{if $id}
    {$title = __("edit")}
{else}
    {$title = __("alw_reminder.new_event")}
{/if}

{include file="common/mainbox.tpl"
    title=$title
    content=$smarty.capture.mainbox
    buttons=$smarty.capture.buttons
}

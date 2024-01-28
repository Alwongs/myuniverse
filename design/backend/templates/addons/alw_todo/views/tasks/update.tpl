{capture name="mainbox"}
    {if $task.task_id}
        {assign var="id" value=$task.task_id}
    {else}
        {assign var="id" value=0}
    {/if}

    <form id="form" action="{""|fn_url}" method="post" name="product_update_form" class="form-horizontal form-edit  cm-disable-empty-files {if $is_form_readonly}cm-hide-inputs{/if}" enctype="multipart/form-data"> {* product update form *}
        <input type="hidden" name="task_id" value="{$id}" />
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
                            name="task_data[task]"
                            id="product_description_product"
                            value="{$task.task}"
                        />
                    </div>
                </div>
            </div>

            <div class="control-group {$no_hide_input_if_shared_product}">
                <label for="product_description_product" class="control-label">{__("description")}</label>
                <div class="controls">
                    <div class="input-group">
                        <input class="input-large"
                            form="form"
                            type="text"
                            name="task_data[description]"
                            id="product_description_product"
                            value="{$task.description}"
                        />
                    </div>
                </div>
            </div>

            <div class="control-group">
                <label for="elm_banner_type" class="control-label">{__("alw_todo.time_plan")}</label>
                <div class="controls">
                    <div class="input-group">
                        <input class="input-small"
                            form="form"
                            type="number"
                            name="task_data[time_plan]"
                            id="product_description_product"
                            value="{$task.time_plan}"
                        />
                    </div>
                </div>
            </div>

            <div class="control-group">
                <label for="elm_banner_type" class="control-label">{__("alw_todo.time_fact")}</label>
                <div class="controls">
                    <div class="input-group">
                        <input class="input-small"
                            form="form"
                            type="number"
                            name="task_data[time_fact]"
                            id="product_description_product"
                            value="{$task.time_fact}"
                        />
                    </div>
                </div>
            </div>


            <div class="control-group">
                <label for="elm_banner_type" class="control-label">{__("alw_todo.is_done")} {$event.is_done}</label>
                <div class="controls">
                <select name="task_data[is_done]" id="elm_banner_type" class="input-small">        
                    <option {if $task.is_done == "N"}selected="selected"{/if} value="N">{__("no")}</option>
                    <option {if $task.is_done == "Y"}selected="selected"{/if} value="Y">{__("yes")}</option>
                </select>
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
            {include file="buttons/save_cancel.tpl" but_meta="cm-product-save-buttons" but_role="submit-link" but_name="dispatch[tasks.update]" but_target_form="product_update_form" save=$id}
        {/capture}
    </form>
{/capture}

{if $id}
    {$title = __("edit")}
{else}
    {$title = __("alw_todo.new_task")}
{/if}

{include file="common/mainbox.tpl"
    title=$title
    content=$smarty.capture.mainbox
    buttons=$smarty.capture.buttons
}

{capture name="mainbox"}

    {$c_url=$config.current_url|fn_query_remove:"sort_by":"sort_order"}
    
    {include_ext file="common/icon.tpl" class="icon-`$search.sort_order_rev`" assign=c_icon}
    {include_ext file="common/icon.tpl" class="icon-dummy" assign=c_dummy}
    
    <form class="form-horizontal form-edit" action="{""|fn_url}" method="post" name="tasks_form">
        
        {include file="common/pagination.tpl" save_current_page=true save_current_url=true}
        
        {if $tasks}
        
            {capture name="tasks_table"}
                <div class="table-responsive-wrapper longtap-selection">
                    <table width="100%" class="table table-sort table-middle table--relative table-responsive">
                    <thead 
                        data-ca-bulkedit-default-object="true" 
                        data-ca-bulkedit-component="defaultObject"
                    >
                    <tr>
                        <th class="left mobile-hide" width="5%">
                            {include file="common/check_items.tpl"}
        
                            <input type="checkbox"
                                class="bulkedit-toggler hide"
                                data-ca-bulkedit-disable="[data-ca-bulkedit-default-object=true]" 
                                data-ca-bulkedit-enable="[data-ca-bulkedit-expanded-object=true]"
                            />
                        </th>

                        <th width="50%">
                            {__("name")}
                        </th>

                        <th width="10%">
                            {__("alw_todo.is_done")}
                        </th>

                        <th width="10%">
                            {include file="common/table_col_head.tpl"
                                type="date"
                                text="{__("alw_todo.time_plan")|truncate:12:"..":true}"
                            }
                        </th>

                        <th width="10%">
                            {include file="common/table_col_head.tpl"
                                type="date"
                                text="{__("alw_todo.time_fact")|truncate:12:"..":true}"
                            }
                        </th> 
                                               
                        <th width="10%">
                            {include file="common/table_col_head.tpl"
                                type="actions"
                                text="{__("actions")}"
                            }
                        </th>
                    </tr>
                    </thead>
                    {foreach from=$tasks item="task"}
                    <tbody>
                        <tr class="cm-row-status-{$tag.status|lower} cm-longtap-target"
                            data-ca-longtap-action="setCheckBox"
                            data-ca-longtap-target="input.cm-item"
                            data-ca-id="{$task.task_id}"
                        >
                            <td width="5%" class="left mobile-hide">
                                <input type="checkbox" class="cm-item cm-item-status-{$tag.status|lower} hide" value="{$task.task_id}" name="task_ids[]"/>
                            </td>

                            <td width="50%" data-th="{__("name")}">
                                <input type="text" name="tasks_data[{$task.task_id}][task]" value="{$task.task}" class="input-hidden alw-input-name">
                            </td>

                            <td width="10%" data-th="{__("is_done")}">
                                <input type="text" name="tasks_data[{$task.task_id}][is_done]" value="{$task.is_done}" class="input-hidden alw-input-name">
                            </td>  

                            <td width="10%" data-th="{__("time_plan")}">
                                <input type="text" name="tasks_data[{$task.task_id}][time_plan]" value="{$task.time_plan}" class="input-hidden alw-input-name">
                            </td>     
                            
                            <td width="10%" data-th="{__("time_fact")}">
                                <input type="text" name="tasks_data[{$task.task_id}][time_fact]" value="{$task.time_fact}" class="input-hidden alw-input-name">
                            </td>                            

                            <td width="10%" data-th="{__("tools")}">
                                <div class="">
                                    {capture name="tools_list"}
                                        <li>{btn type="list" text=__("edit") href="tasks.update?task_id=`$task.task_id`&page_url=tasks.manage"}</li>
                                        <li>{btn type="list" class="cm-confirm" text=__("delete") href="tasks.delete?task_id=`$task.task_id`" method="POST"}</li>
                                    {/capture}
                                    {dropdown content=$smarty.capture.tools_list}
                                </div>
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                    </table>
                </div>
            {/capture}
        
            {include file="common/context_menu_wrapper.tpl"
                form="tasks_form"
                object="tasks"
                items=$smarty.capture.tasks_table
                is_check_all_shown=true
            }
        
        {else}
            <p class="no-items">{__("no_data")}</p>
        {/if}
        
        {include file="common/pagination.tpl"}
    
    </form>

{/capture}

{capture name="adv_buttons"}
    {include file="common/tools.tpl" tool_href="tasks.update" prefix="top" hide_tools="true" title=__("alw_todo.add_task") icon="icon-plus"}
{/capture}

{capture name="buttons"}
    {dropdown content=$smarty.capture.tools_list}
    {if $tags}
        {include file="buttons/save.tpl" but_name="dispatch[tasks.m_update]" but_role="submit-link" but_target_form="tasks_form"}
    {/if}
{/capture}

{capture name="sidebar"}
    {include file="common/saved_search.tpl" dispatch="tasks.manage" view_type="tasks"}
    {include file="addons/tags/views/tags/components/tags_search_form.tpl" dispatch="tasks.manage"}
{/capture}

{include file="common/mainbox.tpl" 
    title=__("alw_todo.tasks") 
    content=$smarty.capture.mainbox 
    adv_buttons=$smarty.capture.adv_buttons 
    buttons=$smarty.capture.buttons 
    sidebar=$smarty.capture.sidebar
}


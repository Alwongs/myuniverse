<section class="analytics-section">

    {if $in_week || $tomorrow || $today || $overdue}
        <div class="analytics-section__content">
            <div class="analytics-section__column analytics-section__column--primary">
                {include file="addons/alw_reminder/views/components/analytics_card.tpl" 
                    title=__("alw_reminder.overdue")
                    data=$overdue
                }
            </div>

            <div class="analytics-section__column analytics-section__column--secondary">
                {include file="addons/alw_reminder/views/components/analytics_card.tpl"  
                    title=__("alw_reminder.today")
                    data=$today
                }
            </div>

            <div class="analytics-section__column analytics-section__column--tertiary">
                {include file="addons/alw_reminder/views/components/analytics_card.tpl"  
                    title=__("alw_reminder.tomorrow")
                    data=$tomorrow
                }
            </div>
        </div>
        
        <div class="analytics-section__content">
            <div class="analytics-section__column">
                {include file="addons/alw_reminder/views/components/analytics_card.tpl"}
            </div>

            <div class="analytics-section__column">
                {include file="addons/alw_reminder/views/components/analytics_card.tpl"}
            </div>

            <div class="analytics-section__column analytics-section__column--tertiary">
                {include file="addons/alw_reminder/views/components/analytics_card.tpl"  
                    title=__("alw_reminder.in_week")
                    data=$in_week
                }
            </div>
        </div>  
    {else}
        <div class="analytics-section__no-items no-items">
            {__("no_data")}
        </div>
    {/if}
</section>

select 
	distinct reported_event_id 
from {{ ref('customer_case_events') }} cce 
where reported_event_id not in (select distinct event_id from {{ ref('user_events') }})
set @n_Game_ID   = 8;                       -- game_id
set @n_Master_Game_ID   = 12;                       -- master_game_id

insert into SYS_GATEWAY select @n_Game_ID,gateway_id,zone_id,gateway_code,gateway_password,
gateway_name,gateway_ip,gateway_mac,gateway_state from SYS_GATEWAY where game_id=@n_Master_Game_ID and gateway_id <>0;

insert into SYS_PRODUCT select product_id,@n_Game_ID,product_code,product_name,product_class,product_sub_class,
product_level,product_use_type,product_period,product_attributes,product_state,insert_time,effect_time,expire_time
from SYS_PRODUCT where game_id =@n_Master_Game_ID;

insert into SYS_PRODUCT_PRICE select price_id,@n_Game_ID,product_id,subject_id,price_origin,price_discount,
effect_time,expire_time from SYS_PRODUCT_PRICE where game_id =@n_Master_Game_ID;

insert into SYS_ACTIVITY_INFO select @n_Game_ID,activity_id,flag_bit,activity_name,activity_type,begin_time,end_time,
activity_state,gift_begin_time,effect_period,role_begin_time,role_end_time,mask,activity_times_limit
from SYS_ACTIVITY_INFO where game_id=@n_Master_Game_ID;

insert into SYS_ACTIVITY_GATEWAY select @n_Game_ID,activity_id,gateway_id
from SYS_ACTIVITY_GATEWAY where game_id=@n_Master_Game_ID;

insert into SYS_ACTIVITY_DETAIL select package_id, @n_Game_ID,activity_id,lower_limit,upper_limit
from SYS_ACTIVITY_DETAIL where game_id=@n_Master_Game_ID;

insert into SYS_ACTIVITY_CONSUME_DETAIL select @n_Game_ID,activity_id,limit_type,subject_id,product_code,
lower_limit,upper_limit,package_id from SYS_ACTIVITY_CONSUME_DETAIL where game_id=@n_Master_Game_ID;

insert into SYS_SERIAL_NO select @n_Game_ID,serial_no,activity_id,media_name,use_limit,serial_state,create_time
from SYS_SERIAL_NO where game_id=@n_Master_Game_ID;

-- ████████  █████   █     █ 
--   █ █   ██    █  █     ██ 
--   █ █████ ███ ███       █ 
--   █ █   █    ██  █      █ 
--   █ █   █████ █   █     █ 
-- ===================== ====================
-- 1. 用戶資料，資料表為 USER

-- 1. 新增：新增六筆用戶資料，資料如下：
--     1. 用戶名稱為`李燕容`，Email 為`lee2000@hexschooltest.io`，Role為`USER`
--     2. 用戶名稱為`王小明`，Email 為`wXlTq@hexschooltest.io`，Role為`USER`
--     3. 用戶名稱為`肌肉棒子`，Email 為`muscle@hexschooltest.io`，Role為`USER`
--     4. 用戶名稱為`好野人`，Email 為`richman@hexschooltest.io`，Role為`USER`
--     5. 用戶名稱為`Q太郎`，Email 為`starplatinum@hexschooltest.io`，Role為`USER`
--     6. 用戶名稱為 透明人，Email 為 opacity0@hexschooltest.io，Role 為 USER

--- 以 insert into 方式新增資料
INSERT INTO "USER" (NAME,email,role)
VALUES ('李燕容','lee2000@hexschooltest.io','USER')
      ,('王小明','wXlTq@hexschooltest.io','USER')
      ,('肌肉棒子','muscle@hexschooltest.io','USER')
      ,('好野人','richman@hexschooltest.io','USER')
      ,('Q太郎','starplatinum@hexschooltest.io','USER')
      ,('透明人','opacity0@hexschooltest.io','USER');

-- 1-2 修改：用 Email 找到 李燕容、肌肉棒子、Q太郎，如果他的 Role 為 USER 將他的 Role 改為 COACH

--- 以 update 方式更新時間
--- 以唯一值的 mail 進行查詢更新
UPDATE "USER"
set ROLE = 'COACH'
WHERE email in ('lee2000@hexschooltest.io'
                ,'muscle@hexschooltest.io'
                ,'starplatinum@hexschooltest.io');

-- 1-3 刪除：刪除USER 資料表中，用 Email 找到透明人，並刪除該筆資料

--- 以 delete 方式刪除時間
--- 以唯一值的 mail 進行查詢刪除
DELETE FROM "USER"
WHERE email in ('opacity0@hexschooltest.io');

-- 1-4 查詢：取得USER 資料表目前所有用戶數量（提示：使用count函式）

--- 以 count 方式計算目前用戶數量。
SELECT 
	COUNT(*) as "用戶總數"
FROM "USER";

-- 1-5 查詢：取得 USER 資料表所有用戶資料，並列出前 3 筆（提示：使用limit語法）

--- 以 order by + limit 方式排序找最前面 3 筆數據。
select
  id as "用戶編號"
  ,name as "用戶名稱"
  ,email as "用戶信箱"
  ,role as "用戶角色"
  ,created_at as "建立資料時間"
  ,updated_at as "更新資料時間"
FROM "USER"
order BY created_at
LIMIT 3;

--  ████████  █████   █    ████  
--    █ █   ██    █  █         █ 
--    █ █████ ███ ███       ███  
--    █ █   █    ██  █     █     
--    █ █   █████ █   █    █████ 
-- ===================== ====================
-- 2. 組合包方案 CREDIT_PACKAGE、客戶購買課程堂數 CREDIT_PURCHASE
-- 2-1. 新增：在`CREDIT_PACKAGE` 資料表新增三筆資料，資料需求如下：
    -- 1. 名稱為 `7 堂組合包方案`，價格為`1,400` 元，堂數為`7`
    -- 2. 名稱為`14 堂組合包方案`，價格為`2,520` 元，堂數為`14`
    -- 3. 名稱為 `21 堂組合包方案`，價格為`4,800` 元，堂數為`21`

--- 以 insert into 方式新增資料
INSERT INTO "CREDIT_PACKAGE" (name,credit_amount,price)
VALUES ('7 堂組合包方案',7,1400)
      ,('14 堂組合包方案',14,2520)
      ,('21 堂組合包方案',21,4800);

-- 2-2. 新增：在 `CREDIT_PURCHASE` 資料表，新增三筆資料：（請使用 name 欄位做子查詢）
    -- 1. `王小明` 購買 `14 堂組合包方案`
    -- 2. `王小明` 購買 `21 堂組合包方案`
    -- 3. `好野人` 購買 `14 堂組合包方案`

--- 以 insert into + select 的方式多筆上傳
--- 新增 王小明 購買 14、21 堂數組合包
INSERT INTO "CREDIT_PURCHASE" (user_id,credit_package_id,purchased_credits,price_paid)
select u.id
      ,cp.id
      ,cp.credit_amount
      ,cp.price
FROM "USER" as "u"
    cross join "CREDIT_PACKAGE" as "cp"
WHERE u.email = 'wXlTq@hexschooltest.io'
		AND cp.name in ('14 堂組合包方案','21 堂組合包方案');
        
--- 以 insert into + select 的方式多筆上傳
--- 新增 好野人 購買 14 堂數組合包
INSERT INTO "CREDIT_PURCHASE" (user_id,credit_package_id,purchased_credits,price_paid)
select u.id
      ,cp.id
      ,cp.credit_amount
      ,cp.price
FROM "USER" as "u"
    cross join "CREDIT_PACKAGE" as "cp"
WHERE u.email = 'richman@hexschooltest.io'
		AND cp.name in ('14 堂組合包方案');


-- ████████  █████   █    ████   
--   █ █   ██    █  █         ██ 
--   █ █████ ███ ███       ███   
--   █ █   █    ██  █         ██ 
--   █ █   █████ █   █    ████   
-- ===================== ====================
-- 3. 教練資料 ，資料表為 COACH ,SKILL,COACH_LINK_SKILL
-- 3-1 新增：在`COACH`資料表新增三筆教練資料，資料需求如下：
    -- 1. 將用戶`李燕容`新增為教練，並且年資設定為2年（提示：使用`李燕容`的email ，取得 `李燕容` 的 `id` ）
    -- 2. 將用戶`肌肉棒子`新增為教練，並且年資設定為2年
    -- 3. 將用戶`Q太郎`新增為教練，並且年資設定為2年

--- 以 insert into + select 的方式多筆上傳
--- 新增有 3 筆數據
INSERT INTO "COACH" (user_id,experience_years)
select id,2
FROM "USER"
WHERE email in ('lee2000@hexschooltest.io','muscle@hexschooltest.io','starplatinum@hexschooltest.io');

-- 3-2. 新增：承1，為三名教練新增專長資料至 `COACH_LINK_SKILL` ，資料需求如下：
    -- 1. 所有教練都有 `重訓` 專長
    -- 2. 教練`肌肉棒子` 需要有 `瑜伽` 專長
    -- 3. 教練`Q太郎` 需要有 `有氧運動` 與 `復健訓練` 專長

--- 以 insert into + select 的方式多筆上傳
--- 新增有 3 筆數據
INSERT INTO "COACH_LINK_SKILL" (coach_id,skill_id)
SELECT 
    c.id as "coach_id"
   ,s.id as "skill_id"
FROM "COACH" as "c"
	CROSS JOIN "SKILL" as "s"
	INNER JOIN "USER" as "u" on c.user_id = u.id
WHERE s.name = '重訓';

--- 以 insert into + select 的方式多筆上傳
--- 新增有 1 筆數據
INSERT INTO "COACH_LINK_SKILL" (coach_id,skill_id)
SELECT 
    c.id as "coach_id"
   ,s.id as "skill_id"
FROM "COACH" as "c"
	CROSS JOIN "SKILL" as "s"
	INNER JOIN "USER" as "u" on c.user_id = u.id
WHERE s.name = '瑜伽'
		AND u.email = 'muscle@hexschooltest.io';

--- 以 insert into + select 的方式多筆上傳
--- 新增有 2 筆數據
INSERT INTO "COACH_LINK_SKILL" (coach_id,skill_id)
SELECT 
    c.id as "coach_id"
   ,s.id as "skill_id"
FROM "COACH" as "c"
	CROSS JOIN "SKILL" as "s"
	INNER JOIN "USER" as "u" on c.user_id = u.id
WHERE s.name in ('有氧運動','復健訓練')
		AND u.email = 'starplatinum@hexschooltest.io';

-- 3-3 修改：更新教練的經驗年數，資料需求如下：
    -- 1. 教練`肌肉棒子` 的經驗年數為3年
    -- 2. 教練`Q太郎` 的經驗年數為5年

--- 以 update + join 的方式進行多筆更新
--- 更新 1 筆數據
update "COACH" 
set experience_years = 3
from "USER" as "u" 
where user_id = u.id
	and u.email = 'muscle@hexschooltest.io';

--- 以 update + join 的方式進行多筆更新
--- 更新 1 筆數據
update "COACH" 
set experience_years = 5
from "USER" as "u" 
where user_id = u.id
	and u.email = 'starplatinum@hexschooltest.io';

-- 3-4 刪除：新增一個專長 空中瑜伽 至 SKILL 資料表，之後刪除此專長。

--- 以 insert into 的方式資料上傳
--- 新增 1 筆數據
insert into "SKILL" (name)
values ('空中瑜伽');

--- 以 delete 的方式資料上傳
--- 刪除 1 筆數據
delete from "SKILL"
where name = '空中瑜伽';


--  ████████  █████   █    █   █ 
--    █ █   ██    █  █     █   █ 
--    █ █████ ███ ███      █████ 
--    █ █   █    ██  █         █ 
--    █ █   █████ █   █        █ 
-- ===================== ==================== 
-- 4. 課程管理 COURSE 、組合包方案 CREDIT_PACKAGE

-- 4-1. 新增：在`COURSE` 新增一門課程，資料需求如下：
    -- 1. 教練設定為用戶`李燕容` 
    -- 2. 在課程專長 `skill_id` 上設定為「 `重訓` 」
    -- 3. 在課程名稱上，設定為「`重訓基礎課`」
    -- 4. 授課開始時間`start_at`設定為2024-11-25 14:00:00
    -- 5. 授課結束時間`end_at`設定為2024-11-25 16:00:00
    -- 6. 最大授課人數`max_participants` 設定為10
    -- 7. 授課連結設定`meeting_url`為 https://test-meeting.test.io

--- 以 insert into + select 的方式多筆上傳
--- join 4 個資料表
insert into "COURSE" (user_id,skill_id,name,start_at,end_at,max_participants,meeting_url)
select 
	u.id
	,s.id
	,'重訓基礎課' as "name"
	,'2024-11-25 14:00:00' as "start_at"
	,'2024-11-25 16:00:00' as "end_at"
	,'10' as "max_participants"
	,'https://test-meeting.test.io' as "meeting_url"
from "USER" as "u"
	inner join "COACH" as "c"
		on  u.id = c.user_id
	inner join "COACH_LINK_SKILL" as "clk"
		on c.id = clk.coach_id
	inner join "SKILL" as "s"
		on s.id = clk.skill_id and s.name = '重訓'
where u.email = 'lee2000@hexschooltest.io';

-- ████████  █████   █    █████ 
--   █ █   ██    █  █     █     
--   █ █████ ███ ███      ████  
--   █ █   █    ██  █         █ 
--   █ █   █████ █   █    ████  
-- ===================== ====================

-- 5. 客戶預約與授課 COURSE_BOOKING
-- 5-1. 新增：請在 `COURSE_BOOKING` 新增兩筆資料：
    -- 1. 第一筆：`王小明`預約 `李燕容` 的課程
        -- 1. 預約人設為`王小明`
        -- 2. 預約時間`booking_at` 設為2024-11-24 16:00:00
        -- 3. 狀態`status` 設定為即將授課
    -- 2. 新增： `好野人` 預約 `李燕容` 的課程
        -- 1. 預約人設為 `好野人`
        -- 2. 預約時間`booking_at` 設為2024-11-24 16:00:00
        -- 3. 狀態`status` 設定為即將授課

--- 以 insert into + select 的方式多筆上傳
--- 新增 1 筆數據
insert into "COURSE_BOOKING" (user_id,course_id,booking_at,status)
select 
	u.id
	,(
		select c.id
		from "COURSE" as "c" 
		    inner join "USER" as "u" 
			on c.user_id = u.id and u.email = 'lee2000@hexschooltest.io'
	 )
	,'2024-11-24 16:00:00'
	,'即將授課'
from "USER" as "u"
where u.email = 'wXlTq@hexschooltest.io';

--- 以 insert into + select 的方式多筆上傳
--- 新增 1 筆數據
insert into "COURSE_BOOKING" (user_id,course_id,booking_at,status)
select 
	u.id
	,(
		select c.id
		from "COURSE" as "c" 
			inner join "USER" as "u" 
				on c.user_id = u.id and u.email = 'lee2000@hexschooltest.io'
	 )
	,'2024-11-24 16:00:00'
	,'即將授課'
from "USER" as "u"
where u.email = 'richman@hexschooltest.io';

-- 5-2. 修改：`王小明`取消預約 `李燕容` 的課程，請在`COURSE_BOOKING`更新該筆預約資料：
    -- 1. 取消預約時間`cancelled_at` 設為2024-11-24 17:00:00
    -- 2. 狀態`status` 設定為課程已取消

--- 以 update + join 的方式進行多筆更新
update "COURSE_BOOKING" 
set cancelled_at = '2024-11-24 17:00:00'
	,status = '課程已取消'
from "USER" as "u"
where u.id = "COURSE_BOOKING".user_id and u.email = 'wXlTq@hexschooltest.io';

-- 5-3. 新增：`王小明`再次預約 `李燕容`   的課程，請在`COURSE_BOOKING`新增一筆資料：
    -- 1. 預約人設為`王小明`
    -- 2. 預約時間`booking_at` 設為2024-11-24 17:10:25
    -- 3. 狀態`status` 設定為即將授課

--- 以 insert into + select 的方式多筆上傳
--- 新增 1 筆數據
insert into "COURSE_BOOKING" (user_id,course_id,booking_at,status)
select 
	u.id
	,(
		select c.id
		from "COURSE" as "c" 
			inner join "USER" as "u" 
				on c.user_id = u.id and u.email = 'lee2000@hexschooltest.io'
	 )
	,'2024-11-24 17:10:25'
	,'即將授課'
from "USER" as "u"
where u.email = 'wXlTq@hexschooltest.io';

-- 5-4. 查詢：取得王小明所有的預約紀錄，包含取消預約的紀錄

--- 以 select 方式查詢資料
SELECT 
	cb.id as "客戶預約課程編號"
	,u.name as "預約人名稱"
	,c.name as "預約課程名稱"
	,booking_at as "預約課程日期時間"
	,status as "授課狀態"
	,join_at as "授課時間"
	,leave_at as "離開課程日期時間"
	,cancelled_at as "取消課程日期時間"
	,cancellation_reason as "取消課程原因"
	,cb.created_at as "建立資料時間"
FROM "COURSE_BOOKING" as "cb"
	inner join "USER" as "u"
		on cb.user_id = u.id
	inner join "COURSE" as "c"
		on c.id = cb.course_id
where u.email = 'wXlTq@hexschooltest.io'
order by 預約課程日期時間; 

-- 5-5. 修改：`王小明` 現在已經加入直播室了，請在`COURSE_BOOKING`更新該筆預約資料（請注意，不要更新到已經取消的紀錄）：
    -- 1. 請在該筆預約記錄他的加入直播室時間 `join_at` 設為2024-11-25 14:01:59
    -- 2. 狀態`status` 設定為上課中

--- 以 update + join 的方式進行多筆更新
--- 找預約課程最大日期來進行更新
update "COURSE_BOOKING" 
set join_at = '2024-11-25 14:01:59'
	,status = '上課中'
from "USER" as "u"
where u.id = "COURSE_BOOKING".user_id 
	and u.email = 'wXlTq@hexschooltest.io'
	and booking_at = (
				select max(booking_at) 
				from "COURSE_BOOKING" 
				where "COURSE_BOOKING".user_id = u.id
			  );

-- 5-6. 查詢：計算用戶王小明的購買堂數，顯示須包含以下欄位： user_id , total。 (需使用到 SUM 函式與 Group By)

--- 以 select 方式查詢資料
select 
	u.id as "用戶編號"
       ,u.name as "用戶姓名"
      ,sum(cpur.purchased_credits) as "購買總堂數"
FROM "CREDIT_PURCHASE" as "cpur"
 	INNER JOIN "USER" as "u" 
	 	on cpur.user_id = u.id and u.email = 'wXlTq@hexschooltest.io'
group by u.id,u.name;

-- 5-7. 查詢：計算用戶王小明的已使用堂數，顯示須包含以下欄位： user_id , total。 (需使用到 Count 函式與 Group By)

--- 以 select 方式查詢資料
SELECT 
	u.name as "預約人名稱"
	,count(join_at) as "已使用堂數"
FROM "COURSE_BOOKING" as "cb"
	inner join "USER" as "u"
		on cb.user_id = u.id and u.email = 'wXlTq@hexschooltest.io'
where join_at is not null
group by u.name; 

-- 5-8. [挑戰題] 查詢：請在一次查詢中，計算用戶王小明的剩餘可用堂數，顯示須包含以下欄位： user_id , remaining_credit
    -- 提示：
    -- select ("CREDIT_PURCHASE".total_credit - "COURSE_BOOKING".used_credit) as remaining_credit, ...
    -- from ( 用戶王小明的購買堂數 ) as "CREDIT_PURCHASE"
    -- inner join ( 用戶王小明的已使用堂數) as "COURSE_BOOKING"
    -- on "COURSE_BOOKING".user_id = "CREDIT_PURCHASE".user_id;

select 
	a.用戶編號
	,a.用戶姓名
        ,a.購買總堂數
	,b.已使用堂數
	,(a.購買總堂數 - b.已使用堂數) as "剩餘可用堂數" 
from
(
	select 
	   u.id as "用戶編號"
	   ,u.email as "用戶信箱"
       ,u.name as "用戶姓名"
      ,sum(cpur.purchased_credits) as "購買總堂數"
	FROM "CREDIT_PURCHASE" as "cpur"
	 	INNER JOIN "USER" as "u" 
		 	on cpur.user_id = u.id
	group by u.id,u.email,u.name
) as "a"
inner join 
(
	SELECT 
		u.id as "用戶編號"
		,u.email as "用戶信箱"
		,u.name as "預約人名稱"
		,count(join_at) as "已使用堂數"
	FROM "COURSE_BOOKING" as "cb"
		inner join "USER" as "u"
			on cb.user_id = u.id
	where join_at is not null
	group by u.id,u.email,u.name
) as "b"
	on a.用戶編號 = b.用戶編號 and a.用戶信箱 = 'wXlTq@hexschooltest.io';

-- ████████  █████   █     ███  
--   █ █   ██    █  █     █     
--   █ █████ ███ ███      ████  
--   █ █   █    ██  █     █   █ 
--   █ █   █████ █   █     ███  
-- ===================== ====================
-- 6. 後台報表
-- 6-1 查詢：查詢專長為重訓的教練，並按經驗年數排序，由資深到資淺（需使用 inner join 與 order by 語法)
-- 顯示須包含以下欄位： 教練名稱 , 經驗年數, 專長名稱

select 
	u.name as "教練名稱"
	,u.role as "用戶角色"
	,s.name as "教練技能"
	,c.experience_years as "年資"
FROM "COACH_LINK_SKILL" AS "clk"
	INNER JOIN "COACH" as "c" 
		on clk.coach_id = c.id
	INNER JOIN "USER" as "u" 
		on c.user_id = u.id
	INNER JOIN "SKILL" as "s" 
		on clk.skill_id = s.id
WHERE s.name = '重訓'
order by 年資 desc;

-- 6-2 查詢：查詢每種專長的教練數量，並只列出教練數量最多的專長（需使用 group by, inner join 與 order by 與 limit 語法）
-- 顯示須包含以下欄位： 專長名稱, coach_total

select 
	s.name as "教練技能"
	,count(c.user_id) as "教練人數"
FROM "COACH_LINK_SKILL" AS "clk"
	INNER JOIN "COACH" as "c" 
		on clk.coach_id = c.id
	INNER JOIN "SKILL" as "s" 
		on clk.skill_id = s.id
group by s.name
order by 教練人數 desc
limit 1;

-- 6-3. 查詢：計算 11 月份組合包方案的銷售數量
-- 顯示須包含以下欄位： 組合包方案名稱, 銷售數量

select 
       cp.name as "課程組合包名稱"
      ,count(cpur.purchased_credits) as "銷售數量"
FROM "CREDIT_PURCHASE" as "cpur"
	INNER JOIN "CREDIT_PACKAGE" as "cp" 
		on cpur.credit_package_id = cp.id
where DATE_PART('month', cpur.purchase_at)  = 11
group by cp.name;

-- 6-4. 查詢：計算 11 月份總營收（使用 purchase_at 欄位統計）
-- 顯示須包含以下欄位： 總營收

select 
       DATE_PART('month', purchase_at) as "購買月份"
      ,SUM(price_paid) as "總營收"
FROM "CREDIT_PURCHASE"
where DATE_PART('month', purchase_at)  = 11
group by DATE_PART('month', purchase_at);

-- 6-5. 查詢：計算 11 月份有預約課程的會員人數（需使用 Distinct，並用 created_at 和 status 欄位統計）
-- 顯示須包含以下欄位： 預約會員人數

SELECT 
	DATE_PART('month', cb.booking_at) as "預約課程月份"
	,count(distinct u.id) as "預約會員人數"
FROM "COURSE_BOOKING" as "cb"
	inner join "COURSE" as "c"
		on c.id = cb.course_id
	inner join "USER" as "u"
		on cb.user_id = u.id
WHERE cb.cancelled_at is null and DATE_PART('month', cb.booking_at)  = 11
group by DATE_PART('month', cb.booking_at);

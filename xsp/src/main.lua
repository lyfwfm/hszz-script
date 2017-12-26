init("0", 0); --以当前应用 Home 键在右边初始化

heroIndex = 1
heroPosList = {226,1213,360,1215,495,1214,633,1213}

placeIndex = 0
placePosList = {550,584,480,583,515,610,583,609}

highx = 547
highy = 418

waterIndex = 0
isFirstTurn = true

timeCount = 0

-- ================
-- 等待8圣水满后，马上放置两个英雄。所以英雄最大两个消耗相加不要大于8圣水
-- ================

-- 判断是在什么界面
function checkGetDisplay()
  -- 是否在主界面
  x, y = findColorInRegionFuzzy(0xffbe2b, 95, 290, 822, 310, 822, 0, 0)
  if x > -1 then
    return 1
  end
  -- 是否在等待界面（点击对战后）
  x, y = findColorInRegionFuzzy(0xfc4345, 95, 290, 950, 310, 950, 0, 0)
  if x > -1 then
    return 2
  end
  -- 是否在战斗界面
  x, y = findColorInRegionFuzzy(0xfff4ff, 95, 178, 1235, 178, 1235, 0, 0)
  if x > -1 then
    return 3
  end
  
  -- 是否在战斗结束界面
  x, y = findColorInRegionFuzzy(0x4eafff, 95, 290, 1140, 310, 1140, 0, 0)
  if x > -1 then
    return 4
  end
  
  -- 是否在竞技场升级降级界面
  x, y = findColorInRegionFuzzy(0x0156a9, 95, 360, 1252, 360, 1252, 0, 0)
  if x > -1 then
    return 6
  end
  
  -- 是否在 已达到奖励上限界面
  x, y = findColorInRegionFuzzy(0x0053a8, 95, 360, 845, 360, 845, 0, 0)
  if x > -1 then
    return 7
  end
	
	-- 是否在 重新连接界面
	x, y = findColorInRegionFuzzy(0xf3f3f3, 95, 374, 767, 374, 767, 0, 0)
	if x > -1 then
		return 8
	end
  
  return 5
  
end

-- 检测物品栏是否可以满足放置
function checkHeroReady(x,y)
  x, y = findColorInRegionFuzzy(0x454545, 95, x, y, x, y, 0, 0)
  if x > -1 then
    return false
  end
  return true
end

function loopAdd(value,max)
  value = value + 1
  if value > max then
    return 1
  else
    return value
  end
end

function loopDel(value,min)
  value = value - 1
  if value < min then
    return 0
  else
    return value
  end
end

-- 9圣水
function isFullWater()
  x, y = findColorInRegionFuzzy(0x55412f, 95, 641, 1252, 641, 1252, 0, 0)
	if x > -1 then
		return false
	end
	return true
end

-- 放置英雄函数
function placeHero()
	--选取英雄
  hx = heroPosList[heroIndex*2-1]
  hy = heroPosList[heroIndex*2]	
  heroIndex = loopAdd(heroIndex,4)
  
  
  -- 点击英雄
  mSleep(50)
  touchDown(1, hx,hy)
  mSleep(50)
  touchUp(1, hx,hy)  
  -- 先尝试能否放置到对方右边
  mSleep(50)
  touchDown(1, highx,highy)
  mSleep(50)
  touchUp(1, highx,highy)  
  -- 点击地图
  placeIndex = loopAdd(placeIndex,4)
  px = placePosList[placeIndex*2-1]
  py = placePosList[placeIndex*2]
  mSleep(50)
  touchDown(1, px,py)
  mSleep(50)
  touchUp(1, px,py)  
end

-- 放置英雄 外层函数
function checkPlaceHero()
  -- 如果满圣水，则其他条件不用判断
  fullWater = isFullWater()	
  if fullWater == false then
    return false
  end
  
  -- 真正开始点击英雄
  placeHero()
  placeHero()
  return true
end

while true do
  mSleep(1000)-- 间歇一秒检测
  
  display = checkGetDisplay()
  sysLog('---display---')
  sysLog(display)
  if display == 1 then
    -- 在主界面，点击开始按钮
    mSleep(50)
    touchDown(1, 231, 831)
    mSleep(50)
    touchUp(1, 231, 831)  
  elseif display == 2 then
    -- 等待界面，继续等待
    mSleep(50)
  elseif display == 3 then
    checkPlaceHero()
  elseif display == 4 then
    -- 结束界面，点击确定
    mSleep(50)
    touchDown(1, 300, 1140)
    mSleep(50)
    touchUp(1, 300, 1140)  
  elseif display == 6 then
    -- 竞技场切换界面
    mSleep(50)
    touchDown(1, 360, 1252)
    mSleep(50)
    touchUp(1, 360, 1252)  
  elseif display == 7 then
    -- 奖励上限
    mSleep(50)
    touchDown(1, 360, 845)
    mSleep(50)
    touchUp(1, 360, 845)  
		elseif display == 8 then
    -- 重新连接
    mSleep(50)
    touchDown(1, 374, 767)
    mSleep(50)
    touchUp(1, 374, 767) 
  else
    mSleep(50)
  end
end
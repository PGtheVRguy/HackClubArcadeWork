
execute as @a[nbt={SleepTimer:50s}] run function revampedbeta:nightmare

execute as @a[scores={is_sprinting=1..}] run attribute @s minecraft:generic.movement_speed base set 0.077
execute as @a[scores={is_sprinting=0}] run attribute @s minecraft:generic.movement_speed base set 0.1
scoreboard players set @a is_sprinting 0
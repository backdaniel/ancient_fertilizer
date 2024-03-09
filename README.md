# Basalt + Fertilizer
In this mod, basalt, one of the most common rocks on Earth, abundant in key nutrients like potassium, phosphorus, and calcium, is crushed and used to enrich the soil, leading to flowers, grass, mushroom and sapling duplication.

Created for [minetest_game](https://content.minetest.net/packages/Minetest/minetest_game/), with gameplay balance in mind. Textures from [too_many_stones](https://content.minetest.net/packages/JoeEnderman/too_many_stones/) (modified).

## Features
- Basalt starts at y = -255 (underground) and below.
- Good for farming flowers for dye.
- New Ancient Basalt texture.
- New Cracked Brick variation.

## Distinctions
- Duplicates vegetation.
- Won't spawn patches of flora on soil.
- Won't "grow" saplings or crops.
- Simple and extensible, just add to `group:can_duplicate`.

## Design Choices
- Duplicates any `group:flora`, `group:mushroom` and `group:sapling` by default.

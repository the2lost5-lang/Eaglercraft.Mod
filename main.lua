-- Grappling Hook Mod für Eaglercraft 26.3

-- 1. Crafting-Rezept registrieren (Armbrust + Angel = Grappling Hook)
if recipes and recipes.addShapeless then
    recipes.addShapeless({
        ingredients = { "minecraft:crossbow", "minecraft:fishing_rod" },
        result = {
            item = "minecraft:fishing_rod",
            count = 1,
            name = "§6Grappling Hook",
            tag = "grappling_hook"
        }
    })
end

-- 2. Funktion beim Rechtsklick / Benutzen
function onItemUse(player, item)
    if not item or item.tag ~= "grappling_hook" then
        return
    end

    -- Prüft, welchen Block du ansiehst (bis zu 35 Blöcke Reichweite)
    local target = player.rayTrace(35)
    if target and target.hit then
        local px, py, pz = player.getPos()
        local dx = target.x - px
        local dy = target.y - py
        local dz = target.z - pz

        -- Berechnet die Entfernung für einen gleichmäßigen Zug
        local dist = math.sqrt(dx * dx + dy * dy + dz * dz)
        if dist > 0 then
            local speed = 1.6
            player.setVelocity(
                (dx / dist) * speed,
                (dy / dist) * speed + 0.35, -- leichter Auftrieb gegen Schwerkraft
                (dz / dist) * speed
            )
        end
    end
end

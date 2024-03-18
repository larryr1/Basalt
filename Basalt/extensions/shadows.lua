
local shadowExtension = {}
local tHex = require("tHex")

function shadowExtension.extensionProperties(original)
    local Element = require("basaltLoader").load("BasicElement")
    Element:initialize("VisualElement")
    Element:addProperty("shadow", "boolean", false)
    Element:addProperty("shadowDirection", "string", "bottomRight")
    Element:addProperty("shadowColor", "color", colors.black)
end

function shadowExtension.init(original)
    local Element = require("basaltLoader").load("BasicElement")
    Element:extend("Init", function(self)
        table.insert(self.renderData, function(self)
            local shadow = self:getShadow()
            if(shadow)then
                local width, height = self:getSize()
                local shadowColor = tHex[self:getShadowColor()]
                local shadowDirection = self:getShadowDirection()
                if(shadowDirection=="bottomRight")then
                    for i=1, height do
                        self:addBlit(width+1, i+1, " ", shadowColor, shadowColor, true)
                    end
                    for i=2, width do
                        self:addBlit(i, height+1, " ", shadowColor, shadowColor, true)
                    end
                end
                if(shadowDirection=="bottomLeft")then
                    for i=1, height do
                        self:addBlit(0, i+1, " ", shadowColor, shadowColor, true)
                    end
                    for i=1, width do
                        self:addBlit(i, height+1, " ", shadowColor, shadowColor, true)
                    end
                end
                if(shadowDirection=="topRight")then
                    for i=0, height-1 do
                        self:addBlit(width+1, i, " ", shadowColor, shadowColor, true)
                    end
                    for i=2, width do
                        self:addBlit(i, 0, " ", shadowColor, shadowColor, true)
                    end
                end
                if(shadowDirection=="topLeft")then
                    for i=0, height-1 do
                        self:addBlit(0, i, " ", shadowColor, shadowColor, true)
                    end
                    for i=1, width-1 do
                        self:addBlit(i, 0, " ", shadowColor, shadowColor, true)
                    end
                end
            end
        end)
        return self
    end)
end


return {
    VisualElement = shadowExtension,
}
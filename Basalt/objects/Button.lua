local Object = require("Object")
local theme = require("theme")
local utils = require("utils")

return function(name)
    -- Button
    local base = Object(name)
    local objectType = "Button"

    base:setValue("Button")
    base:setZIndex(5)
    base.width = 8
    base.bgColor = theme.ButtonBG
    base.fgColor = theme.ButtonFG

    local textHorizontalAlign = "center"
    local textVerticalAlign = "center"

    local object = {
        getType = function(self)
            return objectType
        end;
        setHorizontalAlign = function(self, pos)
            textHorizontalAlign = pos
        end;

        setVerticalAlign = function(self, pos)
            textVerticalAlign = pos
        end;

        setText = function(self, text)
            base:setValue(text)
            return self
        end;

        draw = function(self)
            if (base.draw(self)) then
                if (self.parent ~= nil) then
                    local obx, oby = self:getAnchorPosition()
                    local w,h = self:getSize()
                    local verticalAlign = utils.getTextVerticalAlign(h, textVerticalAlign)

                    if(self.bgColor~=false)then
                        self.parent:drawBackgroundBox(obx, oby, w, h, self.bgColor)
                        self.parent:drawTextBox(obx, oby, w, h, " ")
                    end
                    if(self.fgColor~=false)then self.parent:drawForegroundBox(obx, oby, w, h, self.fgColor) end
                    for n = 1, h do
                        if (n == verticalAlign) then
                            self.parent:setText(obx, oby + (n - 1), utils.getTextHorizontalAlign(self:getValue(), w, textHorizontalAlign))
                        end
                    end
                end
                self:setVisualChanged(false)
            end
        end;

    }
    return setmetatable(object, base)
end
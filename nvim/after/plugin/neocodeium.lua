local neocodeium = require("neocodeium")

-- Accepts the suggestion
neocodeium.accept()

-- Accepts only part of the suggestion if the full suggestion doesn't make sense
neocodeium.accept_word()
neocodeium.accept_line()

-- Clears the current suggestion
neocodeium.clear()

-- Cycles through suggestions by `n` (1 by default) items. Use a negative value to cycle in reverse order
neocodeium.cycle(n)

-- Same as `cycle()`, but also tries to show a suggestion if none is visible.
-- Mostly useful with the enabled `manual` option
neocodeium.cycle_or_complete(n)

-- Checks if a suggestion's virtual text is visible or not (useful for some complex mappings)
neocodeium.visible()

local Config = require('config')


-- require('events.tab-title').setup()
-- require('events.new-tab-button').setup()
-- require('events.right-status').setup()
-- require('events.left-status').setup()
-- require('events.rr').setup()
-- require('events.title').setup()
-- require('events.tabbar')


return Config:init()
   :append(require('config.appearance'))
   -- :append(require('config.bindings'))
   :append(require('config.domains'))
   :append(require('config.fonts'))
   :append(require('config.general'))
   :append(require('config.launch')).options

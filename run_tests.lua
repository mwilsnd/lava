lava = require "lava"
class = lava.class
abstract = lava.abstract
interface = lava.interface
singleton = lava.singleton
mixin = lava.mixin


lava.loadClass "tests/classes/basic_class_a.lua"
lava.loadClass "tests/classes/basic_class_b.lua"
lava.loadClass "tests/classes/basic_class_c.lua"
lava.loadClass "tests/classes/basic_class_d.lua"
lava.loadClass "tests/classes/basic_class_inherit_constructor.lua"

lava.loadClass "tests/classes/shared_class.lua"
lava.loadClass "tests/classes/shared_class_base.lua"
lava.loadClass "tests/classes/shared_class_child_a.lua"
lava.loadClass "tests/classes/shared_class_child_b.lua"
lava.loadClass "tests/classes/shared_class_child_c.lua"
lava.loadClass "tests/classes/malformed_shared_block_runtime.lua"

lava.loadClass "tests/classes/printable.lua"
lava.loadClass "tests/classes/countable.lua"
lava.loadClass "tests/classes/stringable.lua"
lava.loadClass "tests/classes/class_implements_printable.lua"
lava.loadClass "tests/classes/class_implements_many.lua"
lava.loadClass "tests/classes/child_parent_interface.lua"

lava.loadClass "tests/classes/basic_singleton.lua"

lava.loadClass "tests/classes/basic_mixin.lua"
lava.loadClass "tests/classes/basic_mixin_2.lua"
lava.loadClass "tests/classes/basic_mixin_class.lua"
lava.loadClass "tests/classes/basic_mixin_class_2.lua"
lava.loadClass "tests/classes/basic_mixin_class_3.lua"
lava.loadClass "tests/classes/basic_mixin_class_4.lua"

lava.loadClass "tests/classes/abstract.lua"
lava.loadClass "tests/classes/malformed_missing_constructor.lua"

lava.loadClass "tests/classes/fifo.lua"
lava.loadClass "tests/classes/counter.lua"

lu = require "deps/luaunit/luaunit"

dofile "tests/inherit.lua"
dofile "tests/abstract.lua"
dofile "tests/singleton.lua"
dofile "tests/interface.lua"
dofile "tests/mixin.lua"
dofile "tests/shared_blocks.lua"
dofile "tests/misc.lua"
dofile "tests/usage.lua"

lu.run( ... )
import bpy, sys

if bpy.context.object.mode == 'EDIT':
    bpy.ops.object.mode_set(mode='OBJECT')
# delete all selected objects
bpy.ops.object.delete()

for i in range(4, len(sys.argv)):
    bpy.ops.import_scene.obj(filepath=sys.argv[i])

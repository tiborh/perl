#
#	SEIF.cmd
#

require eriMetaPanelMap;
require stdDblClick;
eriMetaPanelMap::AddMenu();
require stdConvert;
add_hook( 'editfilehook', 'stdConvert::ConvertHook');
add_hook('menuloadhook','eriMetaPanelMap::AddMenu');


# EOF


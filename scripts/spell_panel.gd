extends Panel
class_name SpellPanel

@export var spell = "summon_blob"

@onready var spellbook_panel: SpellbookPanel = get_parent()

func _gui_input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
            if spellbook_panel.necromancer != null:
                spellbook_panel.necromancer.selected_spell = spell

extends HBoxContainer
class_name SpellbookPanel

@export var selected_style: StyleBox
@export var unselected_style: StyleBox

@onready var game: Game = get_node("../../..")
@onready var summon_blob_panel: SpellPanel = get_node("SummonBlob")
@onready var summon_demon_panel: SpellPanel = get_node("SummonDemon")

var necromancer: Necromancer
var selected_spell: String

func _process(_delta: float) -> void:
    necromancer = find_necromancer()
    var necromancer_selected_spell = necromancer.selected_spell if necromancer != null else ""

    if selected_spell != necromancer_selected_spell:
        selected_spell = necromancer_selected_spell

        if selected_spell == "summon_blob":
            summon_blob_panel.add_theme_stylebox_override("panel", selected_style)
        else:
            summon_blob_panel.add_theme_stylebox_override("panel", unselected_style)

        if selected_spell == "summon_demon":
            summon_demon_panel.add_theme_stylebox_override("panel", selected_style)
        else:
            summon_demon_panel.add_theme_stylebox_override("panel", unselected_style)

    visible = necromancer != null

func _unhandled_key_input(event: InputEvent) -> void:
    if event is InputEventKey:
        if event.pressed and event.keycode == KEY_1:
            if necromancer:
                necromancer.selected_spell = "summon_blob"

        if event.pressed and event.keycode == KEY_2:
            if necromancer:
                necromancer.selected_spell = "summon_demon"

func find_necromancer() -> Necromancer:
    for node in game.get_children():
        if node is Necromancer:
            return node

    return null

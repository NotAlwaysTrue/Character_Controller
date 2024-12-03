local states = {}

Hook.Patch("Barotrauma.Items.Components.CustomInterface", "CreateGUI", function (instance, ptable)
    if not instance.originalElement.GetAttributeString("type", "") == "uavcontroller" then
        return
    end

    local item = instance.Item

    local frame = instance.GuiFrame
    local menuList = GUI.ListBox(GUI.RectTransform(frame.Rect.Size - GUI.GUIStyle.ItemFrameMargin, frame.RectTransform, GUI.Anchor.Center))

    GUI.TextBlock(GUI.RectTransform(Vector2(1, 0.08), menuList.Content.RectTransform), "UAV Control Panel", nil, nil, GUI.Alignment.Center)

end)
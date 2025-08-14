<?php
class Theme {
    public $id;
    public $name;
    public function __construct($id, $name) {
        $this->id = $id;
        $this->name = $name;
    }
}

class Subtopic {
    public $id;
    public $theme_id;
    public $name;
    public function __construct($id, $theme_id, $name) {
        $this->id = $id;
        $this->theme_id = $theme_id;
        $this->name = $name;
    }
}

class Content {
    public $subtopic_id;
    public $text;
    public function __construct($subtopic_id, $text) {
        $this->subtopic_id = $subtopic_id;
        $this->text = $text;
    }
}

$themes = [
    new Theme(1, "Тема 1"),
    new Theme(2, "Тема 2"),
];

$subtopics = [
    new Subtopic(1, 1, "Подтема 1.1"),
    new Subtopic(2, 1, "Подтема 1.2"),
    new Subtopic(3, 1, "Подтема 1.3"),
    new Subtopic(4, 2, "Подтема 2.1"),
    new Subtopic(5, 2, "Подтема 2.2"),
    new Subtopic(6, 2, "Подтема 2.3"),
];

$contents = [
    new Content(1, "Некий текст, привязанный к Подтеме 1.1"),
    new Content(2, "Некий текст, привязанный к Подтеме 1.2"),
    new Content(3, "Некий текст, привязанный к Подтеме 1.3"),
    new Content(4, "Некий текст, привязанный к Подтеме 2.1"),
    new Content(5, "Некий текст, привязанный к Подтеме 2.2"),
    new Content(6, "Некий текст, привязанный к Подтеме 2.3"),
];

header('Content-Type: application/json; charset=utf-8');
echo json_encode([
    'themes' => $themes,
    'subtopics' => $subtopics,
    'contents' => $contents
], JSON_UNESCAPED_UNICODE);

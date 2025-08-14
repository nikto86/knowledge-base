<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>База знаний</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { border-collapse: collapse; width: 100%; table-layout: fixed; }
        th, td { border: 1px solid #ccc; vertical-align: top; padding: 5px; }
        .clickable { cursor: pointer; padding: 4px; }
        .clickable:hover { background-color: #f0f0f0; }
        .selected { background-color: yellow; }
    </style>
</head>
<body>
    <table>
		<thead>
		<tr>
			<th>Тема</th>
			<th>Подтема</th>
			<th>Содержимое</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td id="themes"></td>
			<td id="subtopics"></td>
			<td id="content"></td>
		</tr>
		</tbody>
	</table>

    <script>
		document.addEventListener('DOMContentLoaded', function() {
			let themesEl = document.getElementById('themes');
			let subtopicsEl = document.getElementById('subtopics');
			let contentEl = document.getElementById('content');

			let dataCache = null;
			let currentThemeId = null;
			let currentSubtopicId = null;

			function loadData() {
				fetch('ajax.php')
					.then(resp => resp.json())
					.then(data => {
						dataCache = data;
						renderThemes();
						// по-умолчанию выбираем первую тему и первую её подтему
						if (data.themes.length > 0) {
							selectTheme(data.themes[0].id);
						}
					});
			}

			function renderThemes() {
				themesEl.innerHTML = '';
				dataCache.themes.forEach(theme => {
					let div = document.createElement('div');
					div.textContent = theme.name;
					div.classList.add('clickable');
					div.dataset.id = theme.id;
					div.addEventListener('click', () => selectTheme(theme.id));
					themesEl.appendChild(div);
				});
			}

			function selectTheme(themeId) {
				currentThemeId = themeId;
				Array.from(themesEl.children).forEach(el => {
					el.classList.toggle('selected', el.dataset.id == themeId);
				});
				renderSubtopics(themeId);
				let firstSub = dataCache.subtopics.find(st => st.theme_id == themeId);
				if (firstSub) {
					selectSubtopic(firstSub.id);
				} else {
					subtopicsEl.innerHTML = '';
					contentEl.textContent = '';
				}
			}

			function renderSubtopics(themeId) {
				subtopicsEl.innerHTML = '';
				dataCache.subtopics
					.filter(st => st.theme_id == themeId)
					.forEach(st => {
						let div = document.createElement('div');
						div.textContent = st.name;
						div.classList.add('clickable');
						div.dataset.id = st.id;
						div.addEventListener('click', () => selectSubtopic(st.id));
						subtopicsEl.appendChild(div);
					});
			}

			function selectSubtopic(subId) {
				currentSubtopicId = subId;
				Array.from(subtopicsEl.children).forEach(el => {
					el.classList.toggle('selected', el.dataset.id == subId);
				});
				let contentItem = dataCache.contents.find(c => c.subtopic_id == subId);
				contentEl.textContent = contentItem ? contentItem.text : '';
			}

			loadData();
		});
		</script>
</body>
</html>

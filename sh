<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
  <meta charset="UTF-8">
  <title>מחשבון מקלחונים</title>
  <style>
    body { font-family: Arial; max-width: 500px; margin: auto; padding: 20px; background: #f4f4f4; }
    h1 { text-align: center; }
    label { display: block; margin: 10px 0 5px; }
    select, button { width: 100%; padding: 10px; font-size: 16px; margin-bottom: 10px; }
    #result { font-weight: bold; font-size: 20px; margin-top: 20px; }
    img { max-width: 100%; margin-top: 15px; display: block; }
  </style>
</head>
<body>
  <h1>מחשבון מקלחונים</h1>

  <form id="form">
    <label>דגם:
      <select name="model" id="model"></select>
    </label>
    <label>סוג זכוכית:
      <select name="glass_type" id="glass_type"></select>
    </label>
    <label>צבע פרופיל:
      <select name="profile_color" id="profile_color"></select>
    </label>
    <label>עובי זכוכית:
      <select name="glass_thickness" id="glass_thickness"></select>
    </label>
    <label>סוג פתיחה:
      <select name="opening_type" id="opening_type"></select>
    </label>
    <label>ציפוי ננו:
      <select name="nano_coating" id="nano_coating"></select>
    </label>
    <label>מתלה מגבת:
      <select name="towel_bar" id="towel_bar"></select>
    </label>
    <label>חיתוך בזכוכית:
      <select name="glass_cut" id="glass_cut"></select>
    </label>
    <button type="submit">חשב מחיר</button>
  </form>

  <div id="result"></div>
  <img id="preview" />

  <script>
    document.addEventListener("DOMContentLoaded", function () {
      const data = {
        model: ["D110", "D210", "V400", "V420"],
        glass_type: ["שקופה", "חלבית", "מעוטרת"],
        profile_color: ["כרום", "שחור", "לבן", "זהב"],
        glass_thickness: ["6 מ\"מ", "8 מ\"מ"],
        nano_coating: ["ללא", "כולל"],
        opening_type: ["דלת ציר", "דלת הזזה", "מקלחון קבוע"],
        towel_bar: ["ללא", "כולל"],
        glass_cut: ["רגיל", "חיתוך בהתאמה"],
        preview_images: {
          "D110": "https://example.com/images/d110.png",
          "D210": "https://example.com/images/d210.png",
          "V400": "https://example.com/images/v400.png",
          "V420": "https://example.com/images/v420.png"
        },
        base_prices: {
          "D110": 1780,
          "D210": 1980,
          "V400": 2250,
          "V420": 2450
        }
      };

      const fields = ["model", "glass_type", "profile_color", "glass_thickness", "opening_type", "nano_coating", "towel_bar", "glass_cut"];
      fields.forEach(id => {
        const select = document.getElementById(id);
        if (!select) {
          console.error(`אלמנט עם id ${id} לא נמצא ב-DOM`);
          return;
        }
        data[id].forEach(opt => {
          const el = document.createElement("option");
          el.textContent = opt;
          el.value = opt;
          select.appendChild(el);
        });
      });

      document.getElementById("form").onsubmit = function(e) {
        e.preventDefault();
        const form = new FormData(e.target);
        const model = form.get("model");
        let price = data.base_prices[model] || 0;

        const additions = {
          glass_type: { "חלבית": 200, "מעוטרת": 400 },
          profile_color: { "שחור": 200, "זהב": 300 },
          nano_coating: { "כולל": 250 },
          towel_bar: { "כולל": 180 },
          glass_cut: { "חיתוך בהתאמה": 220 }
        };

        Object.keys(additions).forEach(key => {
          const value = form.get(key);
          price += additions[key]?.[value] || 0;
        });

        document.getElementById("result").innerText = `מחיר סופי: ₪${price}`;
        document.getElementById("preview").src = data.preview_images[model] || "https://via.placeholder.com/500x300?text=No+Image+Available";
      };

      document.getElementById("preview").onerror = function () {
        this.src = "https://via.placeholder.com/500x300?text=No+Image+Available";
      };
    });
  </script>
</body>
</html>
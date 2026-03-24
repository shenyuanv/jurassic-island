#!/bin/bash
# Generate remaining images for jurassic-island when rate limit resets
set -e
cd ~/clawd/skills/nano-banana-antigravity
REF=~/clawd/projects/jurassic-island/images/scale-reference.png
OUT=~/clawd/projects/jurassic-island/images

gen() {
  local file="$1" prompt="$2"
  if [ -f "$OUT/$file" ]; then echo "SKIP: $file exists"; return 0; fi
  echo "Generating: $file"
  if uv run scripts/generate_image.py --prompt "$prompt" -f "$OUT/$file" -a 4:3 -r 2K -i "$REF" 2>&1; then
    echo "OK: $file"
    sleep 5
  else
    echo "FAIL: $file"
    return 1
  fi
}

gen "ch4-wind-check.png" \
  "Scene: A 7-year-old East Asian boy in khaki safari vest crouching in a dark prehistoric forest, picking up dirt and tossing it into the air to check wind direction. Dust particles floating in a beam of light. In the background a massive Tyrannosaurus Rex is visible feeding. Tense atmosphere. Realistic children's book illustration, cinematic."

gen "ch5-geothermal.png" \
  "Scene: A volcanic geothermal canyon on a prehistoric island. Steam rising from hot springs, bubbling pools of water, warm orange-green light. A 7-year-old East Asian boy in khaki safari vest walks carefully along a narrow rocky path between steaming vents. Dramatic atmosphere, mist and vapor. Realistic children's book illustration."

gen "ch5-dilophosaurus.png" \
  "Scene: A scientifically accurate Dilophosaurus (6 meters long, bipedal theropod with TWO PARALLEL BONY CRESTS on top of head, NO neck frill, NO venom sacs, lean muscular body, possibly with primitive feathers) emerging from volcanic steam in a geothermal canyon. The dinosaur looks powerful and fast. A small 7-year-old boy is hiding behind rocks in foreground. Dramatic misty lighting. Realistic scientific illustration style."

gen "ch5-geyser-escape.png" \
  "Scene: A geyser erupting dramatically with a massive column of steam and hot water in a volcanic canyon. A 7-year-old East Asian boy in khaki vest is running through the steam cloud, using it as cover. Behind the steam curtain a large dinosaur silhouette is barely visible. Dynamic action scene. Realistic children's book illustration."

gen "ch6-radio-tower.png" \
  "Scene: An old rusty radio tower covered in tropical vines on top of a hill on a prehistoric island. Small feathered dinosaurs (bird-like, with visible feathers, looking like a cross between small raptors and modern birds) are nesting on the tower structure. A 7-year-old East Asian boy in khaki vest is climbing the tower. Sunset lighting, warm golden hour. Realistic children's book illustration."

gen "ch6-bird-dinosaurs.png" \
  "Scene: Educational split illustration. Left side shows a small feathered dinosaur (Archaeopteryx - with clear feathered wings, teeth, and clawed fingers). Right side shows modern birds (sparrow, pigeon, parrot). An arrow connects them showing evolution. Clean white/light background with subtle timeline. Scientific illustration style, detailed feather textures, children's book quality."

gen "ch6-rescue.png" \
  "Scene: A rescue helicopter approaching a tropical volcanic island at golden sunset. A 7-year-old East Asian boy in khaki vest waves from a hilltop near a radio tower. In the background, a massive Brachiosaurus (26 meter long-necked sauropod) neck and head extends above the jungle canopy. Beautiful hopeful atmosphere, golden light, clouds. Realistic children's book illustration."

echo "=== All done ==="
cd ~/clawd/projects/jurassic-island
git add -A
git commit -m "Add remaining chapter illustrations" 2>/dev/null || true
git push 2>/dev/null || true
echo "Deployed!"

from PIL import Image
import os

# Target dimensions (reasonable for web)
target_width = 400
target_height = 300

# Get all PNG files in project pic folder
pic_folder = "project pic"
png_files = [f for f in os.listdir(pic_folder) if f.endswith('.png')]

for png_file in png_files:
    file_path = os.path.join(pic_folder, png_file)
    
    # Open image
    img = Image.open(file_path)
    
    # Get current dimensions
    current_width, current_height = img.size
    print(f"Processing {png_file}: {current_width}x{current_height} -> {target_width}x{target_height}")
    
    # Resize maintaining aspect ratio
    img.thumbnail((target_width, target_height), Image.Resampling.LANCZOS)
    
    # Save the resized image
    img.save(file_path, 'PNG', optimize=True)
    print(f"Saved {png_file}")

print("All images resized successfully!")

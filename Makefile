.PHONY: image build run dev clean

IMAGE=latex-resume-kit
SRC_DIR=$(shell pwd)/src
BUILD_DIR=$(shell pwd)/build

# Build Docker image
image:
	docker build -t $(IMAGE):latest .

# Build PDF into build/
build:
	mkdir -p "$(BUILD_DIR)"
	docker run --rm \
		-e TEXINPUTS="/work/src//:" \
		-v "$(SRC_DIR):/work/src" \
		-v "$(BUILD_DIR):/work/build" \
		-w /work/build \
		$(IMAGE):latest \
		latexmk -pdf -interaction=nonstopmode -output-directory=/work/build /work/src/main.tex

watch:
	mkdir -p "$(BUILD_DIR)"
	docker run --rm -it \
		-e TEXINPUTS="/work/src//:" \
		-v "$(SRC_DIR):/work/src" \
		-v "$(BUILD_DIR):/work/build" \
		-w /work/build \
		$(IMAGE):latest \
		latexmk -pdf -pvc -interaction=nonstopmode -output-directory=/work/build /work/src/main.tex

# Clean build directory
clean:
	rm -rf $(BUILD_DIR)/*

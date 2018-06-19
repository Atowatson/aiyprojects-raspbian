PYTHON=python3

.PHONY: all test-download test deb clean

all:
	@echo "make test-download - Download test images"
	@echo "make test - Run tests"
	@echo "make clean - Get rid of all generated files"
	@echo "male deb - Generate Debian package"

test-download:
	$(CURDIR)/src/tests/images/download.sh

test:
	$(PYTHON) -m unittest \
		src/tests/dish_classifier_test.py \
		src/tests/face_detection_test.py \
		src/tests/image_classification_test.py \
		src/tests/object_detection_test.py

deb:
	dpkg-buildpackage -b -rfakeroot -us -uc -tc

# enable, disable, start, stop, restart, status
joy-demo-%:
	sudo systemctl $* joy_detection_demo.service

clean:
	rm -f $(CURDIR)/src/tests/images/*.jpg

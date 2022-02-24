{
  services.xserver = {
    libinput.enable = false;
    synaptics.palmMinZ = 1000;
    synaptics.palmMinWidth = 1000;
    synaptics.vertEdgeScroll = false;
    synaptics.additionalOptions = ''
      Option "VertScrollDelta" "-100"
      Option "HorizScrollDelta" "-100"
    '';
    synaptics.buttonsMap = [ 1 3 2 ];
    synaptics.enable = true;
    synaptics.tapButtons = false;
    synaptics.fingersMap = [ 0 0 0 ];
    synaptics.twoFingerScroll = true;
  };
}

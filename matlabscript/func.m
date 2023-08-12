function out = func(frame)
  if ~isempty(frame)
    out = frame.group;
  else 
    out = []; 
  end
end
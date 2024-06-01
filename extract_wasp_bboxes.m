function [output_bboxes] = extract_wasp_bboxes(input_bboxes, labels)
my_table = [0, 0, 0, 0];
    for k=1:size(labels)
        if labels(k) == 'wasp'
            my_table = [my_table; input_bboxes(k,:)];
        end
    end
    if size(my_table) > 1
        output_bboxes = my_table;
    else
        output_bboxes = input_bboxes;
    end
end


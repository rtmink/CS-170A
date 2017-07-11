function X = classifierx(f, filenames, filenames_smiling)
    
    samplesize = max(size(filenames));
    k = 60;

    [f_bar0, U, singular_values] = avg_face(filenames, k, samplesize);
    [f_bar1, U_smiling, singular_values_smiling] = avg_face(filenames_smiling, k, samplesize);

    c = U' * (f - f_bar0);
    cur_norm = norm(c,2);

    c_smiling = U' * (f - f_bar1);
    cur_norm_smiling = norm(c_smiling,2);

    if cur_norm > cur_norm_smiling
        X = 1;
    else
        X = 0;
    end
end
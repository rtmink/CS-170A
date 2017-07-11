function X = classifiery(f, filenames, filenames_smiling)
    
    samplesize = max(size(filenames));
    k = 60;
    
    [f_bar0, U, singular_values] = avg_face(filenames, k, samplesize);
    [f_bar1, U_smiling, singular_values_smiling] = avg_face(filenames_smiling, k, samplesize);

    dif = f - f_bar0;
    square_dif = dif' * dif;

    dif_smiling = f - f_bar1;
    square_dif_smiling = dif_smiling' * dif_smiling;

    if square_dif >= square_dif_smiling
        X = 1;
    else
        X = 0;
    end
end
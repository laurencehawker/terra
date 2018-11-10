#include "spatraster.h"
#include "SimpleIni/SimpleIni.h"
#include "string_utils.h"


bool SpatRaster::constructFromFile(std::string fname) {

//	bool OK = (fname.substr(0, 3) == "HDF") || (file_exists(fname));
	bool OK = file_exists(fname);
	if (!OK) {
		setError("file does not exist");
		return false;
	}

	std::string ext = getFileExt(fname);

	if (ext != ".grd") {
        #ifdef useGDAL
		return constructFromFileGDAL(fname);
        #endif // useGDAL
	} else {

		CSimpleIniA ini(true, false, false);
		char ss[fname.length()];
		strcpy(ss, fname.c_str());
		SI_Error rc = ini.LoadFile(ss);
		if (rc < 0) {
			return false;

		} else {
			RasterSource s;
			double xmin = atof(ini.GetValue("georeference", "xmin"));
			double xmax = atof(ini.GetValue("georeference", "xmax"));
			double ymin = atof(ini.GetValue("georeference", "ymin"));
			double ymax = atof(ini.GetValue("georeference", "ymax"));
			SpatExtent e(xmin, xmax, ymin, ymax);
			s.extent = e;
			s.datatype = ini.GetValue("data", "datatype");
			s.bandorder = ini.GetValue("data", "bandorder", "");
			s.byteorder = ini.GetValue("data", "byteorder", "");

			std::string smin, smax, snames;
			std::string version = ini.GetValue("version", "version", "1");
			if (version == "1") {
				s.nrow = atoi(ini.GetValue("georeference", "nrows"));
				s.ncol = atoi(ini.GetValue("georeference", "ncols"));
				s.nlyr = atoi(ini.GetValue("data", "nbands"));
				s.crs = ini.GetValue("georeference", "projection");
				s.NAflag = atof(ini.GetValue("data", "nodatavalue"));
				smin = ini.GetValue("data", "minvalue");
				smax = ini.GetValue("data", "maxvalue");
				snames = ini.GetValue("description", "layername");
				s.names = strsplit(snames, ":");
			} else {  // version 2
				s.nrow = atoi(ini.GetValue("dimensions", "nrow"));
				s.ncol = atoi(ini.GetValue("dimensions", "ncol"));
				s.nlyr = atoi(ini.GetValue("dimensions", "nlyr"));
				s.crs = ini.GetValue("georeference", "crs");
				s.NAflag = atof(ini.GetValue("data", "nodata"));
				smin = ini.GetValue("data", "range_min");
				smax = ini.GetValue("data", "range_max");
				snames = ini.GetValue("dimensions", "names");
				s.names = strsplit(snames, ":|:");
			}
			s.range_min = str2dbl(strsplit(smin, ":"));
			s.range_max = str2dbl(strsplit(smax, ":"));
			s.filename = setFileExt(fname, ".gri");
			s.hasRange = std::vector<bool> (s.nlyr, true);

			s.scale.resize(s.nlyr, 1);
			s.offset.resize(s.nlyr, 0);
			s.has_scale_offset = std::vector<bool> (s.nlyr, false);

			s.hasValues = true;
			s.memory = false;
			s.driver = "raster";
			setSource(s);
			return true;
		}
   }
   return true;
}



bool SpatRaster::constructFromFiles(std::vector<std::string> fnames) {

	SpatRaster r = SpatRaster(fnames[0]);
	setSource(r.source[0]);
	for (size_t i=1; i<fnames.size(); i++) {
		r = SpatRaster(fnames[i]);
		if (!compare_geom(r, false, true, true)) {
			setError(fnames[i] = " does not match previous sources");
			return false;
		} else {
			addSource(r);
		}
	}
	return true;
}

